"
helps to build an hypernotion's grammar.
given  the production and representation rules of the metalevel of a vw-grammar.

holds the elements of the meta grammar. meta rules and ortho alphabet.

and builds a grammar with
	- an hypernotion 
	- and the metagramar (nonterminals, terminals, meta rules)	
and starts at the hypernotion

using jay earley parser
"
Class {
	#name : #AFJEMetaGrammar,
	#superclass : #Object,
	#instVars : [
		'nonterminals',
		'terminals',
		'metaProductionRules'
	],
	#category : #'FisherParser-Core-MetaUnification'
}

{ #category : #'instance creation' }
AFJEMetaGrammar class >> metaRules: metaRuleCollection orthoRepresentations: terminalNotionToRepresentationList [ 
	^ self basicNew 
		initializeMetaProductionRules: metaRuleCollection representations: terminalNotionToRepresentationList;
		yourself
]

{ #category : #private }
AFJEMetaGrammar >> buildBodyOf: aHypernotion [
	^ Array
		streamContents: [ :s | 
			aHypernotion
				do: [ :notion | 
					notion isMetanotion
						ifTrue: [ 
							s nextPut: (nonterminals detect: [ :each | each named = notion named ]) ].
					notion isProtonotion
						ifTrue: [ 
							notion do: [ :char | s nextPut: (nonterminals detect: [ :each | each named = char asSymbol ]) ] ] ] ]
]

{ #category : #initialization }
AFJEMetaGrammar >> initialize [
	super initialize.
	nonterminals := Set new.
	terminals := Set new.
	metaProductionRules := SinglyLinkedList new
]

{ #category : #initialization }
AFJEMetaGrammar >> initializeMetaProductionRules: metaRuleCollection representations: terminalNotionToRepresentationList [
	self initialize.
	metaRuleCollection 
		do: [ :each | nonterminals add: (NCNonterminal named: each head named) ].
	terminalNotionToRepresentationList
		do: [ :assoc | 
			nonterminals add: (NCNonterminal named: assoc key).
			terminals add: assoc value ].
	metaProductionRules
		addAll:
			(metaRuleCollection
				collect: [ :each | 
					NCProductionRule
						head: (nonterminals detect: [ :nonterminal | nonterminal named = each head named ])
						body: (self buildBodyOf: each body) ]).
	metaProductionRules
		addAll:
			(terminalNotionToRepresentationList
				collect: [ :assoc | 
					NCProductionRule
						head: (nonterminals detect: [ :nonterminal | nonterminal named = assoc key ])
						body: {(terminals like: assoc value)} ])
]

{ #category : #'instance creation' }
AFJEMetaGrammar >> startAt: aHypernotion [
	" 	builds a grammar with an hypernotion and the metagramar 
		and starts at the given hypernotion "

	| startRule |
	startRule := 
		NCProductionRule 
			headNamed: aHypernotion asString 
			body: (self buildBodyOf: aHypernotion).
	^ JEGrammar
		productionRules:
			((SinglyLinkedList with: startRule)
				addAll: metaProductionRules;
				yourself)
		nonterminals:
			((SinglyLinkedList with: startRule head)
				addAll: nonterminals;
				yourself)
		terminals: terminals
		startNonterminal: startRule head
]
