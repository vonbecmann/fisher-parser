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

{ #category : #'as yet unclassified' }
AFGrammarBuilder class >> productionRules: aCollection representations: aCollection2 [ 
	^ self basicNew 
		initializeProductionRules: aCollection representations: aCollection2;
		yourself
]

{ #category : #building }
AFGrammarBuilder >> buildStartingAt: aHypernotion [
	| startNotion rule |
	startNotion := NCNonterminal named: aHypernotion asString.
	rule := 
		NCProductionRule 
			head: startNotion 
			body: (aHypernotion asArrayOfSymbols collect: [ :each | nonterminals like: each ]).
	^ JEGrammar
		productionRules:
			((SinglyLinkedList with: rule)
				addAll: metaProductionRules;
				yourself)
		nonterminals:
			((Set with: startNotion)
				addAll: nonterminals;
				yourself)
		terminals: terminals
		startNonterminal: startNotion
]

{ #category : #initialization }
AFGrammarBuilder >> initialize [
	super initialize.
	nonterminals := Set new.
	terminals := Set new
]

{ #category : #initialization }
AFGrammarBuilder >> initializeProductionRules: productionRuleCollection representations: terminalNotionToRepresentationList [
	self initialize.
	productionRuleCollection do: [ :each | nonterminals add: each head ].
	terminalNotionToRepresentationList
		do: [ :assoc | 
			nonterminals add: (NCNonterminal named: assoc key).
			terminals add: assoc value ].
	metaProductionRules := SinglyLinkedList new.
	metaProductionRules
		addAll:
			(productionRuleCollection
				collect: [ :each | 
					NCProductionRule
						head: (nonterminals like: each head)
						body: (each body collect: [ :notion | nonterminals like: notion ]) ]).
	metaProductionRules
		addAll:
			(terminalNotionToRepresentationList
				collect: [ :assoc | 
					NCProductionRule
						head: (nonterminals detect: [ :nonterminal | nonterminal named = assoc key ])
						body: {(terminals like: assoc value)} ])
]
