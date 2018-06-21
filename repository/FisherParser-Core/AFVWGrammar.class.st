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
		'startHyperRule',
		'metaRules',
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

{ #category : #initialization }
AFVWGrammar >> checkBoundness [
	" R2. The hypersyntax must not contain any type X rules. 
	A hyper rule is of type X iif it is neither left-bound nor right-bound. "

	alternatives
		do: [ :hrule | 
			(hrule isStrict not and: [ hrule isXType ])
				ifTrue: [ 
					Warning signal:
							(String
								streamContents: [ :s | 
									s
										nextPutAll: 'R2. The hypersyntax must not contain any type X rules.';
										nextPutAll: ' A hyper rule is of type X ';
										nextPutAll: 'iif it is neither left-bound nor right-bound.';
										nextPutAll: ' This hyper rule'; 
										crlf;
										print: hrule;
										crlf;
										nextPutAll: ' is of type X.' ]) ] ]
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
	metaRules := SinglyLinkedList new
]

{ #category : #initialization }
AFVWGrammar >> initializeVWGrammar: aVWGrammar [
	| startNotion ortholetters |
	self initialize.
	vwGrammar := aVWGrammar.
	startNotion := (AFHypernotion with: (AWProtonotion with: '((start))'))
		belongsTo: self;
		yourself.
	ortholetters := Set new.
	ortholetters 
		addAll: startNotion ortholetters;
		addAll: vwGrammar ortholetters.
	vwGrammar metaRules 
		collect: [ :each |
			AWMetaProductionRule 
				head: each head
				body: 	(AFHypernotion belongsTo: self withAllNotionsFrom: each body) ] 
		thenDo: [ :newRule | metaRules add: newRule ].
	matcherCreator := AFMatcherCreator
		metaRules: metaRules
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
		thenCollect: [ :each | each dotAtBeginning ].
	"self checkBoundness."
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
