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
		'startSymbol',
		'firstSet'
	],
	#category : #'FisherParser-Core-Implementation'
}

{ #category : #'instance creation' }
AFJEMetaGrammar class >> metaRules: metaRuleCollection orthoRepresentations: terminalNotionToRepresentationList [ 
	^ self basicNew 
		initializeMetaProductionRules: metaRuleCollection representations: terminalNotionToRepresentationList;
		yourself
]

{ #category : #initialization }
AFJEMetaGrammar >> computeFirstAndFollowSets [
	" compute first and follow sets "

	self computeFirstSet
]

{ #category : #initialization }
AFJEMetaGrammar >> computeFirstSet [
	| previousSize |
	[ previousSize := firstSet size.
	metaProductionRules
		do: [ :rule | 
			rule body isEmpty
				ifTrue: [ firstSet at: rule head put: #epsilon ]
				ifFalse: [ | index symbol |
					index := 0.
					[ symbol := rule body at: (index := index + 1).
					symbol isTerminal
						ifTrue: [ firstSet at: rule head put: symbol ]
						ifFalse: [ 
							firstSet
								at: rule head
								putAll: ((firstSet at: symbol) copyWithout: #epsilon) ] ]
						doWhileTrue: [ 
							index < rule body size
								and: [ symbol isNonterminal
										and: [ (firstSet at: symbol) includes: #epsilon ] ] ].
					(rule body
						allSatisfy: [ :eachSymbol | 
							eachSymbol isNonterminal
								and: [ (firstSet at: eachSymbol) includes: #epsilon ] ])
						ifTrue: [ firstSet at: rule head put: #epsilon ] ] ].
	previousSize = firstSet size ] whileFalse
]

{ #category : #'inspector extensions' }
AFJEMetaGrammar >> gtInspectorFirstSetIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ composite table
		title: [ 'first set' ];
		display: [ nonterminals ];
		column: 'Nonterminal' evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each ];
		send: [ :each | firstSet at: each ];
		showOnly: 50;
		yourself
]

{ #category : #'inspector extensions' }
AFJEMetaGrammar >> gtInspectorMetaProductionRulesIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ composite table
		title: [ 'meta rules' ];
		display: [ metaProductionRules asArray ];
		column: 'Production Rule' evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each ];
		send: [ :each | each ];
		showOnly: 50;
		yourself
]

{ #category : #initialization }
AFJEMetaGrammar >> initialize [
	startSymbol := NCNonterminal named: 'hypernotion-axiom'.
	nonterminals := Set new.
	terminals := Set new.
	metaProductionRules := SinglyLinkedList new.
	firstSet := MultiValuedDictionary dictionary: Dictionary collection: Set
]

{ #category : #initialization }
AFJEMetaGrammar >> initializeMetaProductionRules: metaRuleCollection representations: terminalNotionToRepresentationList [
	self initialize.
	metaRuleCollection 
		do: [ :each | nonterminals add: each head ].
	terminalNotionToRepresentationList
		do: [ :assoc | 
			nonterminals add: assoc key.
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
						head: (nonterminals like: assoc key)
						body: {(terminals like: assoc value)} ]).
	nonterminals add: startSymbol.
	nonterminals do: [ :each | firstSet at: each putAll: #() ].
	metaProductionRules 
		select: [ :each | each isRepresentation ] 
		thenDo: [ :each | firstSet at: each head put: each body first ].
	
	
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
