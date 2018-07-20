"
helps to create an hypernotion's grammar.
given  the meta production rules and ortholetters of the metalevel of a vw-grammar.

holds the elements of the meta grammar. 
- meta rules
- nonterminals
- terminals
- symbols: nonterminals and terminals.

and creates a hypernotion's grammar with
	- an hypernotion 
	- and the metagramar 
"
Class {
	#name : #AFMetaGrammar,
	#superclass : #Object,
	#instVars : [
		'nonterminals',
		'terminals',
		'metaProductionRules',
		'firstSet',
		'parseTable'
	],
	#category : #'FisherParser-Core-Implementation'
}

{ #category : #'instance creation' }
AFMetaGrammar class >> metaRules: metaRuleCollection ortholetters: ortholetters [
	^ self basicNew
		initializeMetaProductionRules: metaRuleCollection ortholetters: ortholetters;
		yourself
]

{ #category : #testing }
AFMetaGrammar >> checkIsLLOne [
	parseTable
		keysDo: [ :key | 
			(parseTable at: key) size > 1
				ifTrue: [ 
					Error
						signal:
							(String
								streamContents: [ :s | 
									s
										nextPutAll: 'FIRST CONFLICT at ';
										print: key;
										nextPutAll: ' -> '.
									(parseTable at: key) do: [ :rule | s print: rule ] separatedBy: [ s space ] ]) ] ]
]

{ #category : #initialization }
AFMetaGrammar >> computeFirstSet [
	| previousSize |
	[ 	previousSize := firstSet size.
		metaProductionRules 
			do: [ :rule | firstSet at: rule head putAll: (firstSet firstOf: rule body) ].
		previousSize = firstSet size ] whileFalse
]

{ #category : #initialization }
AFMetaGrammar >> computeParseTable [
	" compute parse table using first set. then you can test if there's a first conflict "

	metaProductionRules
		do: [ :rule | 
			(terminals intersection: (firstSet firstOf: rule body))
				do: [ :terminal | 
					parseTable 
						at: (OrderedPair first: rule head second: terminal) 
						put: rule ] ]
]

{ #category : #'inspector extensions' }
AFMetaGrammar >> gtInspectorFirstSetIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ composite table
		title: [ 'First Set' ];
		display: [ firstSet keys ];
		column: 'Nonterminal' evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each ];
		send: [ :each | firstSet at: each ];
		showOnly: 50;
		yourself
]

{ #category : #'inspector extensions' }
AFMetaGrammar >> gtInspectorMetaProductionRulesIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ composite table
		title: [ 'Meta Rules' ];
		display: [ metaProductionRules asArray ];
		column: 'Meta Rule' evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each ];
		send: [ :each | each ];
		showOnly: 50;
		yourself
]

{ #category : #initialization }
AFMetaGrammar >> initialize [
	nonterminals := Set new.
	terminals := Set new.
	metaProductionRules := SinglyLinkedList new.
	firstSet := MultiValuedDictionary dictionary: Dictionary collection: Set.
	parseTable := MultiValuedDictionary dictionary: Dictionary collection: Set
]

{ #category : #initialization }
AFMetaGrammar >> initializeMetaProductionRules: metaRuleCollection ortholetters: ortholetters [
	self initialize.
	metaRuleCollection do: [ :each | nonterminals add: each head ].
	ortholetters 
		do: [ :letter |
			nonterminals add: (NCNonterminal named: letter).
			terminals add: (NCTerminal character: letter) ].
	nonterminals do: [ :each | firstSet at: each putAll: #() ].
	metaRuleCollection
		collect: [ :each | 
				NCProductionRule
					head: (nonterminals like: each head)
					body: (each body buildBodyOf: nonterminals) ]
		thenDo: [ :each | metaProductionRules add: each ].
	ortholetters 
		collect: [ :letter | 
			NCProductionRule
				head: (nonterminals like: (NCNonterminal named: letter))
				body: {(terminals like: (NCTerminal character: letter))} ]
		thenDo: [ :each | 
			metaProductionRules add: each.
			firstSet at: each head put: each body first ]
]

{ #category : #accessing }
AFMetaGrammar >> metaProductionRules [
	^ metaProductionRules
]

{ #category : #accessing }
AFMetaGrammar >> nonterminals [
	^ nonterminals
]

{ #category : #'instance creation' }
AFMetaGrammar >> startAt: aHypernotion [
	" creates a hypernotion's grammar using the metagramar "

	^ AFHypernotionGrammar hypernotion: aHypernotion metaGrammar: self
]

{ #category : #accessing }
AFMetaGrammar >> terminals [
	^ terminals
]
