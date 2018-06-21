"
helps to build an hypernotion's grammar.
given  the production and representation rules of the metalevel of a vw-grammar.

holds the elements of the meta grammar. meta rules and ortho alphabet.

and builds a grammar with
	- an hypernotion 
	- and the metagramar (nonterminals, terminals, meta rules)	
and starts at the hypernotion

using jay earley parser.
Definition 12. Let M, V, Rm be defined as for two-level grammars(Definition 1). A hypernotion system HS is a 4-tuple (M, V, Rm, H), where H in (M u V)+, the hypernotion (axiom).

"
Class {
	#name : #AFJEMetaGrammar,
	#superclass : #Object,
	#instVars : [
		'nonterminals',
		'terminals',
		'metaProductionRules',
		'startSymbol'
	],
	#category : #'FisherParser-Core-MetaMatching'
}

{ #category : #'instance creation' }
AFJEMetaGrammar class >> metaRules: metaRuleCollection orthoRepresentations: terminalNotionToRepresentationList [ 
	^ self basicNew 
		initializeMetaProductionRules: metaRuleCollection representations: terminalNotionToRepresentationList;
		yourself
]

{ #category : #initialization }
AFJEMetaGrammar >> initialize [
	startSymbol := NCNonterminal named: 'hypernotion-axiom'.
	nonterminals := Set new.
	terminals := Set new.
	metaProductionRules := SinglyLinkedList new
]

{ #category : #initialization }
AFJEMetaGrammar >> initializeMetaProductionRules: metaRuleCollection representations: terminalNotionToRepresentationList [
	self initialize.
	metaRuleCollection 
		do: [ :each | nonterminals add: each head ].
	terminalNotionToRepresentationList
		do: [ :assoc | 
			nonterminals add: (NCNonterminal named: assoc key).
			terminals add: assoc value ].
	metaProductionRules
		addAll:
			(metaRuleCollection
				collect: [ :each | 
					NCProductionRule
						head: (nonterminals like: each head)
						body: (each body buildBodyOf: nonterminals) ]).
	metaProductionRules
		addAll:
			(terminalNotionToRepresentationList
				collect: [ :assoc | 
					NCProductionRule
						head: (nonterminals detect: [ :nonterminal | nonterminal named = assoc key ])
						body: {(terminals like: assoc value)} ]).
	nonterminals add: startSymbol 
]

{ #category : #'instance creation' }
AFJEMetaGrammar >> startAt: aHypernotion [
	" 	builds a grammar with an hypernotion and the metagramar 
		and starts at the given hypernotion "

	| startRule |
	startRule := NCProductionRule head: startSymbol body: (aHypernotion buildBodyOf: nonterminals).
	^ JEGrammar
		productionRules:
			((SinglyLinkedList with: startRule)
				addAll: metaProductionRules;
				yourself)
		nonterminals: nonterminals
		terminals: terminals
		startNonterminal: startRule head
]
