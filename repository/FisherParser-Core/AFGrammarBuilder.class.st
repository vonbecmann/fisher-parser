"
helps to build an hypernotion's grammar.
given  the production and representation rules of the metalevel of a vw-grammar.

"
Class {
	#name : #AFGrammarBuilder,
	#superclass : #Object,
	#instVars : [
		'nonterminals',
		'terminals',
		'metaProductionRules'
	],
	#category : #'FisherParser-Core-Implementation'
}

{ #category : #'instance creation' }
AFGrammarBuilder class >> metaRules: metaRuleCollection orthoRepresentations: terminalNotionToRepresentationList [ 
	^ self basicNew 
		initializeMetaProductionRules: metaRuleCollection representations: terminalNotionToRepresentationList;
		yourself
]

{ #category : #building }
AFGrammarBuilder >> buildStartingAt: aHypernotion [
	| startNotion startRule |
	startNotion := aHypernotion asNonterminal.
	startRule := NCProductionRule
		head: startNotion
		body: (aHypernotion asArrayOfSymbols collect: [ :each | nonterminals like: each ]).
	^ JEGrammar
		productionRules:
			((SinglyLinkedList with: startRule)
				addAll: metaProductionRules;
				yourself)
		nonterminals: (nonterminals copyWith: startNotion)
		terminals: terminals
		startNonterminal: startNotion
]

{ #category : #initialization }
AFGrammarBuilder >> initialize [
	super initialize.
	nonterminals := Set new.
	terminals := Set new.
	metaProductionRules := SinglyLinkedList new
]

{ #category : #initialization }
AFGrammarBuilder >> initializeMetaProductionRules: metaRuleCollection representations: terminalNotionToRepresentationList [
	self initialize.
	metaRuleCollection do: [ :each | nonterminals add: each head asNonterminal ].
	terminalNotionToRepresentationList
		do: [ :assoc | 
			nonterminals add: (NCNonterminal named: assoc key).
			terminals add: assoc value ].
	metaProductionRules
		addAll:
			(metaRuleCollection
				collect: [ :each | 
					NCProductionRule
						head: (nonterminals like: each head asNonterminal)
						body: (each body asArrayOfSymbols collect: [ :notion | nonterminals like: notion ]) ]).
	metaProductionRules
		addAll:
			(terminalNotionToRepresentationList
				collect: [ :assoc | 
					NCProductionRule
						head: (nonterminals detect: [ :nonterminal | nonterminal named = assoc key ])
						body: {(terminals like: assoc value)} ])
]
