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
	| metanotions protonotions terminals allHyperRules |
	metanotions := Set new.
	protonotions := Set new.
	metaRules
		do: [ :metaRule | 
			metanotions add: metaRule head.
			metanotions addAll: metaRule body metanotions.
			protonotions addAll: metaRule body protonotions ].
	hyperRules
		do: [ :hyperRule | 
			protonotions addAll: hyperRule head protonotions.
			hyperRule body do: [ :each | protonotions addAll: each protonotions ] ].
	terminals := Set new.
	representations
		do: [ :hyperRule | 
			self assert: hyperRule isRepresentation.
			protonotions addAll: hyperRule head protonotions.
			terminals add: hyperRule body first first ].
	allHyperRules := OrderedCollection withAll: hyperRules.
	allHyperRules addAll: representations.
	^ AVWGrammar
		metanotions: metanotions
		protonotions: protonotions
		terminals: terminals
		metaRules: metaRules
		hyperRules: allHyperRules
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
