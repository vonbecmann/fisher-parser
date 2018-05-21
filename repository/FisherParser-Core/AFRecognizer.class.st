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

{ #category : #testing }
AFRecognizer >> evaluate: aString [
	| chart n |
	n := aString size + 1.
	chart := (1 to: n) collect: [ :index | AFColumn number: index ].
	chart first add: (grammar startHyperRule dotAtBeginning startAt: chart first).
	chart
		withIndexDo: [ :column :i | 
			column isEmpty
				ifTrue: [ ^ Error signal: 'failed at ' , (chart at: i - 1) asString ].
			i < n
				ifTrue: [ 
					grammar representationRules 
						do: [ :hyperRule |
							(hyperRule dotAtBeginning symbolAtDot matches: (aString at: i))
								ifTrue: [
									column add: (hyperRule dotAtBeginning startAt: column).
									(chart at: i + 1) add: (hyperRule dotAtEnd startAt: column) ]]]].
	^ chart
]

{ #category : #initialization }
AFRecognizer >> initializeGrammar: aVWGrammar [
	self initialize.
	grammar := aVWGrammar
]
