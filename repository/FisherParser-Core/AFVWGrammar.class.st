"
a vw grammar with some restrictions that Fisher mentions in his paper.

startNotion is a hypernotion. is a protonotion. 
	augments the given grammar with this hypernotion.
startHyperRule is hyper rule used by the algorithm.
	augments the given grammar with this hyper rule.


"
Class {
	#name : #AFVWGrammar,
	#superclass : #Object,
	#instVars : [
		'vwGrammar',
		'startNotion',
		'startHyperRule',
		'representationRules',
		'alternatives',
		'ortholetters',
		'metaProductionRules',
		'orthoRepresentations'
	],
	#category : #'FisherParser-Core-Public'
}

{ #category : #'instance creation' }
AFVWGrammar class >> evw: aVWRuleString representations: terminalNotionToRepresentationList [
	^ self basicNew
		initializeVWGrammar: 
			(AVWGrammar 
				evw: aVWRuleString 
				representations: terminalNotionToRepresentationList);
		yourself
]

{ #category : #testing }
AFVWGrammar >> accepts: aString [
	^ (AFRecognizer of: self) accepts: aString
]

{ #category : #private }
AFVWGrammar >> alternativesOf: aProtonotion [
	"^ alternatives at: aProtonotion ifAbsent: #()"

	| matches |
	matches := SinglyLinkedList new.
	alternatives
		do: [ :hrule | 
			(self matches: hrule head against: aProtonotion)
				ifTrue: [ matches addLast: hrule ] ].
	^ matches
]

{ #category : #testing }
AFVWGrammar >> analizeAccepts: aString [
	^ (AFAnalyticalRecognizer of: self) accepts: aString
]

{ #category : #accessing }
AFVWGrammar >> hyperRulesSize [
	^ vwGrammar hyperRulesSize
]

{ #category : #accessing }
AFVWGrammar >> hypernotions [
	^ vwGrammar hypernotions
]

{ #category : #initialization }
AFVWGrammar >> initialize [
	startNotion := AWHypernotion
		withAll:
			{(AWProtonotion with: 'start').
			(AWProtonotion with: 'notion')}.
	ortholetters := Set new.
	alternatives := ArrayMultiValuedDictionary dictionary: Dictionary 
]

{ #category : #initialization }
AFVWGrammar >> initializeVWGrammar: aVWGrammar [
	self initialize.
	vwGrammar := aVWGrammar.
	startHyperRule := AFHyperRule head: startNotion body: {vwGrammar startNotion}.
	alternatives at: startNotion put: startHyperRule.
	vwGrammar hyperRules
		collect: [ :each | each asAFHyperRule ]
		thenDo: [ :newRule | alternatives at: newRule head put: newRule ].
	representationRules := alternatives
		select: [ :each | each isRepresentation ]
		thenCollect: [ :each | each dotAtBeginning ].
	vwGrammar protonotions do: [ :protonotion | protonotion do: [ :char | ortholetters add: char ] ].
	metaProductionRules := vwGrammar metaRules collect: [ :metaRule | metaRule asProductionRule ].
	orthoRepresentations := ortholetters
		collect: [ :char | char asSymbol -> (NCTerminal character: char) ]
		as: Array
]

{ #category : #private }
AFVWGrammar >> matches: aHypernotion against: aProtonotion [ 
	^ false
]

{ #category : #accessing }
AFVWGrammar >> metaRulesSize [
	^ vwGrammar metaRulesSize 
]

{ #category : #accessing }
AFVWGrammar >> metanotions [
	^ vwGrammar metanotions
]

{ #category : #printing }
AFVWGrammar >> printOn: aStream [
	"Append to the argument, aStream, a sequence of characters that  
	identifies the receiver."

	aStream
		nextPutAll: self class name;
		nextPut: $(;
		print: startHyperRule;
		nextPut: $)
]

{ #category : #printing }
AFVWGrammar >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]

{ #category : #accessing }
AFVWGrammar >> protonotions [
	^ vwGrammar protonotions 
]

{ #category : #private }
AFVWGrammar >> representationRules [
	^ representationRules
]

{ #category : #private }
AFVWGrammar >> startHyperRule [
	^ startHyperRule
]

{ #category : #accessing }
AFVWGrammar >> startNotion [
	^ startNotion
]

{ #category : #accessing }
AFVWGrammar >> terminals [
	^ vwGrammar terminals
]
