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
		'nonterminalHypernotions',
		'startHyperRule',
		'representationRules',
		'metaGrammar',
		'hyperRules'
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
		checkMetaGrammarIsLLOne;
		computeHypernotionsFirstSet;
		checkHypernotionsAreLLOne;
		checkHyperRulesLeftHandSides;
		checkBoundness;
		computeCrossReferences;
		yourself
]

{ #category : #testing }
AFVWGrammar >> accepts: aString [
	^ (AFRecognizer of: self) accepts: aString
]

{ #category : #analysis }
AFVWGrammar >> analyzeAccepts: aString [
	^ (AFAnalyticalRecognizer of: self) accepts: aString
]

{ #category : #analysis }
AFVWGrammar >> analyzeParse: aString [
	^ (AFAnalyticalParser of: self) parse: aString
]

{ #category : #initialization }
AFVWGrammar >> checkBoundness [
	" R2. The hypersyntax must not contain any type X rules. 
	A hyper rule is of type X iif it is neither left-bound nor right-bound. "

	hyperRules
		do: [ :hyperRule | 
			hyperRule isXType
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
										print: hyperRule;
										crlf;
										nextPutAll: ' is of type X.' ]) ] ]
]

{ #category : #initialization }
AFVWGrammar >> checkHyperRulesLeftHandSides [
	hyperRules
		do: [ :hyperRule | 
			hyperRule head matchesEmpty
				ifTrue: [ 
					Error
						signal:
							(String
								streamContents: [ :s | 
									s
										nextPutAll: 'left hand side of hyper rule ';
										print: hyperRule;
										nextPutAll: ' matches empty' ]) ] ]
]

{ #category : #initialization }
AFVWGrammar >> checkHypernotionsAreLLOne [
	"P1.	the defining context-free grammar of each hypernotion 
			in the vw-grammar is LL(1) "

	nonterminalHypernotions do: [ :hn | hn checkIsLLOne ]
]

{ #category : #initialization }
AFVWGrammar >> checkMetaGrammarIsLLOne [
	metaGrammar checkIsLLOne
]

{ #category : #initialization }
AFVWGrammar >> computeCrossReferences [
	" compute cross-references "

	hyperRules
		do: [ :hyperRule | 
			hyperRule body
				withIndexDo: [ :rightHypernotion :index | 
					rightHypernotion isTerminal
						ifFalse: [ 
							hyperRules
								do: [ :crossHyperRule | 
									(crossHyperRule head superMatches: rightHypernotion)
										ifTrue: [ 
											index == 1
												ifTrue: [ crossHyperRule head addBackwardCrossReference: hyperRule ].
											rightHypernotion addForwardCrossReference: crossHyperRule ] ].
							(rightHypernotion isProtonotion and: [ rightHypernotion forwardCrossReferences isEmpty ])
								ifTrue: [ 
									Error
										signal:
											(String
												streamContents: [ :s | 
													s
														nextPutAll: 'Protonotion ';
														print: rightHypernotion;
														nextPutAll: ' used but not defined' ]) ] ] ] ]
]

{ #category : #initialization }
AFVWGrammar >> computeHypernotionsFirstSet [
	nonterminalHypernotions do: [ :hn | hn computeFirstSet ]
]

{ #category : #'inspector extensions' }
AFVWGrammar >> gtInspectorDefinitionIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ vwGrammar gtInspectorDefinitionIn: composite
]

{ #category : #'inspector extensions' }
AFVWGrammar >> gtInspectorHyperRulesIn: composite [
	<gtInspectorPresentationOrder: 2>
	^ vwGrammar gtInspectorHyperRulesIn: composite
]

{ #category : #'inspector extensions' }
AFVWGrammar >> gtInspectorMetaRulesIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ vwGrammar gtInspectorMetaRulesIn: composite
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
AFVWGrammar >> initializeVWGrammar: aVWGrammar [
	| startNotion startHypernotion hypernotionDict |
	vwGrammar := aVWGrammar.
	startNotion := AWProtonotion with: '_top'.
	metaGrammar := 
	AFMetaGrammar
		metaRules: vwGrammar metaRules
		ortholetters: (vwGrammar ortholetters, startNotion letters).
	hypernotionDict := Dictionary new.
	vwGrammar hyperRulesHypernotions  
		do: [ :hypernotion | 
			hypernotionDict 
				at: hypernotion 
				put: (AFHypernotion belongsTo: metaGrammar withAllNotionsFrom: hypernotion) ].
	startHypernotion := AFHypernotion belongsTo: metaGrammar with: startNotion.
	nonterminalHypernotions := (hypernotionDict reject: [:hn | hn isTerminal ]) values copyWith: startHypernotion.
	startHyperRule := AFHyperRule head: startHypernotion bodyWith: (hypernotionDict at: vwGrammar startNotion).
	hyperRules := SinglyLinkedList with: startHyperRule.
	vwGrammar hyperRules
		collect: [ :each | 
			AFHyperRule
				head: (hypernotionDict at: each head)
				body: 	(each body collect: [ :hypernotion | hypernotionDict at: hypernotion ])
				instanceOf: each ]
		thenDo: [ :newRule | hyperRules addLast: newRule ].
	representationRules := hyperRules
		select: [ :each | each isRepresentation ]
		thenCollect: [ :each | each dotAtBeginning ]
]

{ #category : #private }
AFVWGrammar >> metaGrammar [
	^ metaGrammar
]

{ #category : #accessing }
AFVWGrammar >> metaRulesSize [
	^ vwGrammar metaRulesSize 
]

{ #category : #accessing }
AFVWGrammar >> metanotions [
	^ vwGrammar metanotions
]

{ #category : #parsing }
AFVWGrammar >> parse: aString [
	^ (AFParser of: self) parse: aString
]

{ #category : #parsing }
AFVWGrammar >> parseTree: aString [
	^ (AFTreeParser of: self) parse: aString
]

{ #category : #printing }
AFVWGrammar >> printOn: aStream [
	"Append to the argument, aStream, a sequence of characters that  
	identifies the receiver."

	aStream
		nextPutAll: self class name;
		nextPut: $(;
		print: vwGrammar startNotion;
		nextPut: $)
]

{ #category : #printing }
AFVWGrammar >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]

{ #category : #private }
AFVWGrammar >> productionRuleAt: anAFHyperRule [ 
	^ anAFHyperRule 
]

{ #category : #accessing }
AFVWGrammar >> protonotions [
	^ vwGrammar protonotions 
]

{ #category : #private }
AFVWGrammar >> representationRulesDo: aBlock [
	representationRules do: aBlock
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
