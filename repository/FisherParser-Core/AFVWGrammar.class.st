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
		'startNotion',
		'ortholetters',
		'vwGrammar',
		'startHyperRule',
		'alternatives',
		'bottomUpAlternatives',
		'representationRules',
		'matcherBuilder'
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
AFVWGrammar >> buildHyperRuleWithHead: aHypernotion andBody: notionCollection [
	^ AFHyperRule
		head:
			((AFHypernotion withAll: aHypernotion notions)
				belongsTo: self;
				yourself)
		body:
			(notionCollection
				collect: [ :notion | 
					(AFHypernotion withAll: notion notions)
						belongsTo: self;
						yourself ])
]

{ #category : #private }
AFVWGrammar >> createMatcherFor: aHypernotion [ 
	^ aHypernotion createUsing: matcherBuilder
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
	startNotion := 
		(AFHypernotion with: (AWProtonotion with: '((start))'))
			belongsTo: self;
			yourself.
	ortholetters := Set new.
	startNotion do: [ :protonotion | protonotion do: [ :char | ortholetters add: char ] ]
]

{ #category : #initialization }
AFVWGrammar >> initializeVWGrammar: aVWGrammar [
	self initialize.
	vwGrammar := aVWGrammar.
	ortholetters addAll: vwGrammar ortholetters.
	matcherBuilder := 
		AFMatcherBuilder 
			metaRules: vwGrammar metaRules
			orthoRepresentations: (ortholetters collect: [ :char | char asSymbol -> (NCTerminal character: char) ]).
	startHyperRule := 
		AFHyperRule 
			head: startNotion 
			body: { ((AFHypernotion withAll: vwGrammar startNotion notions)
							belongsTo: self;
							yourself) }.
	alternatives := SinglyLinkedList with: startHyperRule.
	vwGrammar hyperRules 
		collect: [ :each | self buildHyperRuleWithHead: each head andBody: each body ] 
		thenDo: [ :newRule | alternatives addLast: newRule ].
	bottomUpAlternatives := alternatives reject: [ :each | each isRepresentation or: [ each isEpsilon ] ].
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
