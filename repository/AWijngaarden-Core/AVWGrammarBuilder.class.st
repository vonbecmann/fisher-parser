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
	metanotions := metaRules
		collect: [ :metaRule | metaRule head ]
		as: Set.
	metaRules do: [ :metaRule | notions addAll: metaRule notions ].
	hypernotions := metaRules
		collect:
			[ :metaRule | metaRule body newInstanceWith: metanotions and: notions ]
		as: Set.
	metaRuleSet := metaRules
		collect: [ :each | 
			AWMetaProductionRule
				head: (metanotions like: each head)
				body: (hypernotions like: each body) ]
		as: Set.
	metaRuleSet
		do: [ :metaRule | index at: metaRule put: (lineup indexOf: metaRule) ].
	hyperRules do: [ :hRule | notions addAll: hRule notions ].
	hyperRules
		do: [ :hRule | 
			hypernotions
				add: (hRule head newInstanceWith: metanotions and: notions);
				addAll:
					(hRule body
						collect:
							[ :hypernotion | hypernotion newInstanceWith: metanotions and: notions ]) ].
	representations
		do: [ :repRule | 
			self assert: repRule isRepresentation.
			notions addAll: repRule notions ].
	representations
		do: [ :repRule | 
			hypernotions
				add: (repRule head collect: [ :notion | notions like: notion ]);
				addAll:
					(repRule body
						collect:
							[ :hypernotion | hypernotion collect: [ :notion | notions like: notion ] ]) ].
	hyperRuleSet := hyperRules
		collect: [ :each | 
			AWHyperRule
				head: (hypernotions like: each head)
				body: (each body collect: [ :hypernotion | hypernotions like: hypernotion ]) ]
		as: Set.
	hyperRuleSet
		do: [ :hyperRule | index at: hyperRule put: (lineup indexOf: hyperRule) ].
	representationSet := representations
		collect: [ :each | 
			AWHyperRule
				head: (hypernotions like: each head)
				body: (each body collect: [ :hypernotion | hypernotions like: hypernotion ]) ]
		as: Set.
	representationSet
		do: [ :hyperRule | index at: hyperRule put: (lineup indexOf: hyperRule) ].
	^ AVWGrammar
		metanotions: metanotions
		protonotions: (notions select: [ :each | each isProtonotion ])
		hypernotions: hypernotions
		terminals: (notions select: [ :each | each isTerminal ])
		metaRules: (metaRuleSet sorted: [ :a :b | (index at: a) < (index at: b) ])
		hyperRules:
			(hyperRuleSet sorted: [ :a :b | (index at: a) < (index at: b) ])
				, (representationSet sorted: [ :a :b | (index at: a) < (index at: b) ])
		startAt: hyperRules first head
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
