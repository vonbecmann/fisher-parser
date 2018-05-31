"
first attempt to recognize a string of a vw grammar
"
Class {
	#name : #AFRecognizer,
	#superclass : #Object,
	#instVars : [
		'grammar'
	],
	#category : #'FisherParser-Core-Implementation'
}

{ #category : #'instance creation' }
AFRecognizer class >> of: aVWGrammar [
	^ self basicNew
		initializeGrammar: aVWGrammar;
		yourself
]

{ #category : #testing }
AFRecognizer >> accepts: aString [
	| chart |
	chart := self evaluate: aString.
	^ chart last includes: (grammar startHyperRule dotAtEnd startAt: chart first)
]

{ #category : #private }
AFRecognizer >> addPreterminalsWith: word at: column [
	grammar representationRules
		do: [ :dottedHyperRule | 
			(dottedHyperRule symbolAtDot matches: word)
				ifTrue: [ column add: (dottedHyperRule startAt: column) ] ]
]

{ #category : #private }
AFRecognizer >> bottomUpPredict: aProtonotion at: aColumn [
	grammar bottomUpAlternatives
		do: [ :hrule | 
			| substitution |
			substitution := hrule body first match: aProtonotion.
			substitution isSolution
				ifTrue: [ aColumn add: ((hrule apply: substitution) dotAtBeginning startAt: aColumn) ] ]
]

{ #category : #private }
AFRecognizer >> complete: item at: column [
	item predictionItems
		do: [ :previous | 
			| substitution |
			substitution := previous symbolAtDot match: item head.
			substitution isSolution
				ifTrue: [ column add: (previous moveDotForwardAfterApplying: substitution) ] ]
]

{ #category : #private }
AFRecognizer >> evaluate: words [
	| chart n |
	n := words size + 1.
	chart := AFChart new: n.
	chart first add: (grammar startHyperRule dotAtBeginning startAt: chart first).
	chart
		withIndexDo: [ :column :i | 
			column isEmpty
				ifTrue: [ ^ Error signal: 'failed at ' , (chart at: i - 1) asString ].
			i < n
				ifTrue: [ self addPreterminalsWith: (words at: i) at: column ].
			column
				processItems: [ :item | 
					item isFinal
						ifTrue: [ 
							item head isProtonotion 
								ifTrue: 
									 [ self bottomUpPredict: item head at: item start.
									 	self complete: item at: column  ] ]
						ifFalse: [ 
							item symbolAtDot isTerminal
								ifTrue: [ 
									(i < n and: [ item symbolAtDot matches: (words at: i) ])
										ifTrue: [ (chart at: i + 1) add: item moveDotForward ] ].
							item symbolAtDot isProtonotion
								ifTrue: [ self topDownPredict: item symbolAtDot at: column ].
							item symbolAtDot isHypernotion 
								ifTrue: [ self gapScan: item at: column ] ] ] ].
	^ chart
]

{ #category : #private }
AFRecognizer >> gapScan: item at: column [
	" gap scanner "

	| substitution |
	substitution := item symbolAtDot match: AFHypernotion empty.
	substitution isSolution
		ifTrue: [ column add: (item moveDotForwardAfterApplying: substitution) ]
]

{ #category : #initialization }
AFRecognizer >> initializeGrammar: aVWGrammar [
	self initialize.
	grammar := aVWGrammar
]

{ #category : #private }
AFRecognizer >> topDownPredict: aProtonotion at: aColumn [
	grammar alternatives 
		do: [ :hrule | 
			| substitution |
			substitution := hrule head match: aProtonotion.
			substitution isSolution
				ifTrue: [ aColumn add: ((hrule apply: substitution) dotAtBeginning startAt: aColumn) ] ]
]
