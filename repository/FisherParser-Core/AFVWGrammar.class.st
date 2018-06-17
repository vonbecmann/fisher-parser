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
		'ortholetters',
		'vwGrammar',
		'startHyperRule',
		'alternatives',
		'bottomUpAlternatives',
		'representationRules',
		'matcherCreator'
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
AFVWGrammar >> alternatives [
	^ alternatives
]

{ #category : #testing }
AFVWGrammar >> analizeAccepts: aString [
	^ (AFAnalyticalRecognizer of: self) accepts: aString
]

{ #category : #private }
AFVWGrammar >> bottomUpAlternatives [
	^ bottomUpAlternatives
]

{ #category : #private }
AFVWGrammar >> createMatcherFor: aHypernotion [ 
	^ aHypernotion createMatcherUsing: matcherCreator
]

{ #category : #'inspector extensions' }
AFVWGrammar >> gtInspectorDefinitionIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ vwGrammar gtInspectorDefinitionIn: composite
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
	super initialize.
	ortholetters := Set new.

]

{ #category : #initialization }
AFVWGrammar >> initializeVWGrammar: aVWGrammar [
	| startNotion |
	self initialize.
	vwGrammar := aVWGrammar.
	startNotion := (AFHypernotion with: (AWProtonotion with: '((start))'))
		belongsTo: self;
		yourself.
	startNotion protonotions do: [ :protonotion | ortholetters addAll: protonotion letters ].
	ortholetters addAll: vwGrammar ortholetters.
	matcherCreator := AFMatcherCreator
		metaRules: vwGrammar metaRules
		orthoRepresentations: (ortholetters collect: [ :char | char asSymbol -> (NCTerminal character: char) ]).
	startHyperRule := AFHyperRule
		head: startNotion
		bodyWith: (AFHypernotion belongsTo: self withAllNotionsFrom: vwGrammar startNotion).
	alternatives := SinglyLinkedList with: startHyperRule.
	vwGrammar hyperRules
		collect: [ :each | 
			AFHyperRule
				head: (AFHypernotion belongsTo: self withAllNotionsFrom: each head)
				body:
					(each body
						collect: [ :hypernotion | 
							AFHypernotion belongsTo: self withAllNotionsFrom: hypernotion ]) ]
		thenDo: [ :newRule | alternatives addLast: newRule ].
	bottomUpAlternatives := alternatives
		reject: [ :each | each isRepresentation or: [ each isEpsilon ] ].
	representationRules := alternatives
		select: [ :each | each isRepresentation ]
		thenCollect: [ :each | each dotAtBeginning ]
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
	^ vwGrammar startNotion
]

{ #category : #accessing }
AFVWGrammar >> terminals [
	^ vwGrammar terminals
]
