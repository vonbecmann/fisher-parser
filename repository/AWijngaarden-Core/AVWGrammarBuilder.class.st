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
	| lineup index metanotions protonotions hypernotions terminals metaRuleSet hyperRuleSet representationSet |
	lineup := OrderedCollection new
		addAll: metaRules;
		addAll: hyperRules;
		addAll: representations;
		yourself.
	index := Dictionary new.
	metanotions := Set new.
	protonotions := Set new.
	hypernotions := Set new.
	terminals := Set new.
	metaRuleSet := Set withAll: metaRules.
	metaRuleSet
		do: [ :metaRule | 
			metanotions add: metaRule head.
			metanotions addAll: metaRule body metanotions.
			protonotions addAll: metaRule body protonotions.
			hypernotions add: metaRule body.
			index at: metaRule put: (lineup indexOf: metaRule) ].
	hyperRuleSet := self buildHyperRulesWith: hyperRules and: metanotions.
	hyperRuleSet
		do: [ :hyperRule | 
			protonotions addAll: hyperRule head protonotions.
			hypernotions
				add: hyperRule head;
				addAll: hyperRule body.
			hyperRule body do: [ :each | protonotions addAll: each protonotions ].
			index at: hyperRule put: (lineup indexOf: hyperRule) ].
	representationSet := Set withAll: representations.
	representationSet
		do: [ :hyperRule | 
			self assert: hyperRule isRepresentation.
			protonotions addAll: hyperRule head protonotions.
			hypernotions
				add: hyperRule head;
				addAll: hyperRule body.
			terminals add: hyperRule body first first.
			index at: hyperRule put: (lineup indexOf: hyperRule) ].
	^ AVWGrammar
		metanotions: metanotions
		protonotions: protonotions
		hypernotions: hypernotions
		terminals: terminals
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
				head: (self buildHypernotionWith: each head and: metanotionSet)
				body: (each body collect: [ :hn | self buildHypernotionWith: hn and: metanotionSet ]) ]
		thenDo: [ :hrule | hyperRuleSet add: hrule ].
	^ hyperRuleSet
]

{ #category : #private }
AVWGrammarBuilder >> buildHypernotionWith: hn and: metanotionSet [
	^ AWHypernotion
		withAll:
			(hn notions
				collect: [ :notion | 
					notion isMetanotion
						ifTrue: [ 
							metanotionSet
								detect: [ :metanotion | metanotion = notion ]
								ifNone: [ 
									Error
										signal:
											(String
												streamContents: [ :s | 
													s
														nextPutAll: 'Unknown Metanotion ';
														print: notion;
														nextPutAll: ' in ';
														print: hn ]) ] ]
						ifFalse: [ notion ] ])
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
