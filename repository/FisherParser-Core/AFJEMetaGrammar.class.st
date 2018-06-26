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
		'firstSet',
		'firstTable'
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

	self computeFirstSet.
	self computeFirstTable.
]

{ #category : #initialization }
AFJEMetaGrammar >> computeFirstSet [
	| previousSize |
	[ 	previousSize := firstSet size.
		metaProductionRules 
			do: [ :rule | firstSet at: rule head putAll: (firstSet firstOf: rule body) ].
		previousSize = firstSet size ] whileFalse
]

{ #category : #initialization }
AFJEMetaGrammar >> computeFirstTable [
	metaProductionRules
		do: [ :rule | 
			(firstSet firstOf: rule body)
				do: [ :terminal | 
					firstTable
						at: (OrderedPair first: rule head second: terminal)
						put: rule ] ]
]

{ #category : #'inspector extensions' }
AFJEMetaGrammar >> gtInspectorFirstSetIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ composite table
		title: [ 'first set' ];
		display: [ firstSet keys ];
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
	nonterminals := Set new.
	terminals := Set new.
	metaProductionRules := SinglyLinkedList new.
	firstSet := MultiValuedDictionary dictionary: Dictionary collection: Set.
	firstTable := MultiValuedDictionary dictionary: Dictionary collection: Set
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
	nonterminals do: [ :each | firstSet at: each putAll: #() ].
	metaRuleCollection
		collect: [ :each | 
				NCProductionRule
					head: (nonterminals like: each head)
					body: (each body buildBodyOf: nonterminals) ]
		thenDo: [ :each | metaProductionRules add: each ].
	terminalNotionToRepresentationList
		collect: [ :assoc | 
			NCProductionRule
				head: (nonterminals like: assoc key)
				body: {(terminals like: assoc value)} ]
		thenDo: [ :each | 
			metaProductionRules add: each.
			firstSet at: each head put: each body first ]
]

{ #category : #testing }
AFJEMetaGrammar >> isLLOne [
	firstTable
		keysDo: [ :key | 
			(firstTable at: key) size > 1
				ifTrue: [ ^ false ] ].
	^ true
]

{ #category : #'instance creation' }
AFJEMetaGrammar >> startAt: aHypernotion [
	" 	builds a grammar with an hypernotion and the metagramar 
		and starts at the given hypernotion "

	| startSymbol startRule |
	startSymbol := NCNonterminal named: 'hypernotion-axiom'.
	startRule := NCProductionRule head: startSymbol body: (aHypernotion buildBodyOf: nonterminals).
	^ JEGrammar
		productionRules:
			((SinglyLinkedList with: startRule)
				addAll: metaProductionRules;
				yourself)
		nonterminals: (nonterminals copyWith: startSymbol) 
		terminals: terminals
		startNonterminal: startSymbol 
]
