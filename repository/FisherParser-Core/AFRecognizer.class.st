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
AFRecognizer >> evaluate: words [
	| chart n |
	n := words size + 1.
	chart := (1 to: n) collect: [ :index | AFColumn number: index ].
	self topDownPredict: grammar startNotion at: chart first.
	chart
		withIndexDo: [ :column :i | 
			column isEmpty
				ifTrue: [ ^ Error signal: 'failed at ' , (chart at: i - 1) asString ].
			i < n
				ifTrue: [ self addPreterminalsWith: (words at: i) at: column ].
			column
				processItems: [ :item | 
					item isFinal
						ifTrue: [  ]
						ifFalse: [ 
							item symbolAtDot isTerminal
								ifTrue: [ 
									(i < n and: [ item symbolAtDot matches: (words at: i) ])
										ifTrue: [ (chart at: i + 1) add: item moveDotForward ] ].
							item symbolAtDot isProtonotion
								ifTrue: [ self topDownPredict: item symbolAtDot at: column ] ] ] ].
	^ chart
]

{ #category : #initialization }
AFRecognizer >> initializeGrammar: aVWGrammar [
	self initialize.
	grammar := aVWGrammar
]

{ #category : #private }
AFRecognizer >> topDownPredict: aProtonotion at: aColumn [
	(grammar alternativesOf: aProtonotion)
		do: [ :hrule | aColumn add: (hrule dotAtBeginning startAt: aColumn) ]
]
