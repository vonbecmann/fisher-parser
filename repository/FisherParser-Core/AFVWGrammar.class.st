"
a vw grammar with some restrictions that Fisher mentions in his paper.
"
Class {
	#name : #AFVWGrammar,
	#superclass : #Object,
	#instVars : [
		'vwGrammar',
		'startNotion',
		'startHyperRule',
		'representationRules',
		'alternatives'
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
AFVWGrammar >> alternativesOf: aHypernotion [
	^ alternatives at: aHypernotion ifAbsent: #()
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
	alternatives := ArrayMultiValuedDictionary dictionary: Dictionary 
]

{ #category : #initialization }
AFVWGrammar >> initializeVWGrammar: aVWGrammar [
	self initialize.
	vwGrammar := aVWGrammar.
	startHyperRule := AWHyperRule head: startNotion body: {vwGrammar startNotion}.
	representationRules := vwGrammar hyperRules
		select: [ :each | each isRepresentation ]
		thenCollect: [ :each | each dotAtBeginning ].
	alternatives at: startNotion put: startHyperRule.
	vwGrammar hyperRules do: [ :each | alternatives at: each head put: each ]
]

{ #category : #accessing }
AFVWGrammar >> metaRulesSize [
	^ vwGrammar metaRulesSize 
]

{ #category : #accessing }
AFVWGrammar >> metanotions [
	^ vwGrammar metanotions
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
