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
	^ chart last includes: (grammar startHyperRule dotAtEnd startedAt: chart first)
]

{ #category : #testing }
AFRecognizer >> evaluate: aString [
	| chart n |
	n := aString size + 1.
	chart := (1 to: n) collect: [ :index | AFColumn number: index ].
	chart first add: (grammar startHyperRule dotAtBeginning startedAt: chart first).
	chart 
		withIndexDo: [ :column :i |
			
			
		
		  ].
	^ chart
]

{ #category : #initialization }
AFRecognizer >> initializeGrammar: aVWGrammar [
	self initialize.
	grammar := aVWGrammar
]
