"
knows how to build a vw-grammar
metanotions is a Set. unique.
protonotions is a Set. unique.
hypernotions is a Set. unique.
metarules is a Set. unique.
hyperrules is a Set. unique.
terminals is a Set. unique.
start symbol is a hypernotion.

"
Class {
	#name : #AVWGrammarBuilder,
	#superclass : #Object,
	#instVars : [
		'metaRules',
		'hyperRules',
		'representations'
	],
	#category : #'AWijngaarden-Core'
}

{ #category : #building }
AVWGrammarBuilder >> build [
	| lineup index notions metanotions hypernotions metaRuleSet hyperRuleSet representationSet |
	lineup := OrderedCollection new
		addAll: metaRules;
		addAll: hyperRules;
		addAll: representations;
		yourself.
	index := Dictionary new.
	notions := Set new.
	metanotions := Set new.
	hypernotions := Set new.
	metaRules do: [ :metaRule | 
		notions addAll: metaRule notions.		
		metanotions add: metaRule head.
		hypernotions add: metaRule body ].
	hyperRules do: [ :hRule |
		notions addAll: hRule notions.
		hypernotions addAll: hRule hypernotions ].
	representations do: [ :repRule |
		self assert: repRule isRepresentation.
		notions addAll: repRule notions.
		hypernotions addAll: repRule hypernotions ].
	
	metaRuleSet := self buildMetaRulesWithAll: metaRules and: metanotions.
	metaRuleSet do: [ :metaRule | index at: metaRule put: (lineup indexOf: metaRule) ].
	hyperRuleSet := self buildHyperRulesWith: hyperRules and: metanotions.
	hyperRuleSet do: [ :hyperRule | index at: hyperRule put: (lineup indexOf: hyperRule) ].
	representationSet := Set withAll: representations.
	representationSet do: [ :hyperRule | index at: hyperRule put: (lineup indexOf: hyperRule) ].
	^ AVWGrammar
		metanotions: metanotions
		protonotions: (notions select: [ :each | each isProtonotion ])
		hypernotions: hypernotions
		terminals: (notions select: [ :each | each isTerminal ])
		metaRules: (metaRuleSet sorted: [ :a :b | (index at: a) < (index at: b) ])
		hyperRules: 
			((hyperRuleSet sorted: [ :a :b | (index at: a) < (index at: b) ]),
			(representationSet sorted: [ :a :b | (index at: a) < (index at: b) ]))
		startAt: hyperRules first head
]

{ #category : #private }
AVWGrammarBuilder >> buildHyperRulesWith: hypeRuleCollection and: metanotionSet [
	| hyperRuleSet |
	hyperRuleSet := Set new.
	hypeRuleCollection
		collect: [ :each | 
			AWHyperRule
				head:
					(each head
						collect: [ :notion | 
							notion isMetanotion
								ifTrue: [ 
									metanotionSet
										like: notion
										ifAbsent: [ self unknown: notion in: each head ] ]
								ifFalse: [ notion ] ])
				body:
					(each body
						collect: [ :hypernotion | 
							hypernotion
								collect: [ :notion | 
									notion isMetanotion
										ifTrue: [ 
											metanotionSet
												like: notion
												ifAbsent: [ self unknown: notion in: hypernotion ] ]
										ifFalse: [ notion ] ] ]) ]
		thenDo: [ :hyperRule | hyperRuleSet add: hyperRule ].
	^ hyperRuleSet
]

{ #category : #private }
AVWGrammarBuilder >> buildMetaRulesWithAll: metaRuleCollection and: metanotionSet [
	| metaRuleSet |
	metaRuleSet := Set new.
	metaRuleCollection
		collect: [ :each | 
			AWMetaProductionRule
				head: (metanotionSet like: each head)
				body:
					(each body
						collect: [ :notion | 
							notion isMetanotion
								ifTrue: [ metanotionSet like: notion ifAbsent: [ self unknown: notion in: each ] ]
								ifFalse: [ notion ] ]) ]
		thenDo: [ :metaRule | metaRuleSet add: metaRule ].
	^ metaRuleSet
]

{ #category : #accessing }
AVWGrammarBuilder >> hyperRules: aCollection [
	self
		assert: aCollection isNotEmpty
		description: 'The collection of hyper rules cannot be empty.'.
	hyperRules := aCollection
]

{ #category : #accessing }
AVWGrammarBuilder >> metaRules: aCollection [
	self
		assert: aCollection isNotEmpty
		description: 'The collection of meta rules cannot be empty.'.
	metaRules := aCollection
]

{ #category : #accessing }
AVWGrammarBuilder >> representations: terminalNotionToRepresentationList [
	self
		assert: terminalNotionToRepresentationList isNotEmpty
		description: 'The collection of representation rules cannot be empty.'.
	representations := 
	terminalNotionToRepresentationList
		collect: [ :assoc | 
			AWHyperRule
				head: (AWHypernotion withAll: (assoc key collect: [ :n | n asNotion ]))
				body: {(AWHypernotion with: assoc value)} ]
]

{ #category : #private }
AVWGrammarBuilder >> unknown: metanotion in: rule [
	^ Error
		signal:
			(String
				streamContents: [ :s | 
					s
						nextPutAll: 'Unknown Metanotion ';
						print: metanotion;
						nextPutAll: ' in ';
						print: rule ])
]
