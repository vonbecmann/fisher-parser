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
		'alternatives',
		'representationRules',
		'metaGrammar'
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

{ #category : #testing }
AFVWGrammar >> analyzeAccepts: aString [
	^ (AFAnalyticalRecognizer of: self) accepts: aString
]

{ #category : #initialization }
AFVWGrammar >> checkBoundness [
	" R2. The hypersyntax must not contain any type X rules. 
	A hyper rule is of type X iif it is neither left-bound nor right-bound. "

	alternatives
		do: [ :hrule | 
			(hrule isXTypeIffForAll: self metanotions)
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

{ #category : #initialization }
AFVWGrammar >> checkHyperRulesLeftHandSides [
	alternatives
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

	alternatives
		do: [ :hyperRule | 
			hyperRule isRepresentation
				ifTrue: [ hyperRule head checkIsLLOne ]
				ifFalse: [ hyperRule checkHypernotionsAreLLOne ] ]
]

{ #category : #initialization }
AFVWGrammar >> checkMetaGrammarIsLLOne [
	metaGrammar checkIsLLOne
]

{ #category : #initialization }
AFVWGrammar >> computeCrossReferences [
	" compute cross-references "

	alternatives
		do: [ :hyperRule | 
			hyperRule body
				withIndexDo: [ :rightHypernotion :index | 
					rightHypernotion isTerminal
						ifFalse: [ 
							alternatives
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
AFVWGrammar >> initializeVWGrammar: aVWGrammar [
	| startNotion hypernotionDict |
	self initialize.
	vwGrammar := aVWGrammar.
	startNotion := AWProtonotion with: '((start))'.
	metaGrammar := 
	AFMetaGrammar
		metaRules: vwGrammar metaRules
		ortholetters: (vwGrammar ortholetters, startNotion letters).
	hypernotionDict := Dictionary new.
	vwGrammar hypernotions 
		do: [ :hypernotion | 
			hypernotionDict 
				at: hypernotion 
				put: (AFHypernotion belongsTo: metaGrammar withAllNotionsFrom: hypernotion) ].
	startHyperRule := AFHyperRule
		head: (AFHypernotion belongsTo: metaGrammar with: startNotion)
		bodyWith: (hypernotionDict at: vwGrammar startNotion).
	alternatives := SinglyLinkedList with: startHyperRule.
	vwGrammar hyperRules
		collect: [ :each | 
			AFHyperRule
				head: (hypernotionDict at: each head)
				body: 	(each body collect: [ :hypernotion | hypernotionDict at: hypernotion ]) ]
		thenDo: [ :newRule | alternatives addLast: newRule ].
	representationRules := alternatives
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
