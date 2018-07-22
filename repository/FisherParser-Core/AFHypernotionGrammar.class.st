"
a hypernotion's grammar. (some called it hypernotion system).

use jay earley parser as a pattern matching algorithm.
the hypernotion system is uniquely assignable (u.a.) [wegner]

Definition 12. Let M, V, Rm be defined as for two-level grammars(Definition 1). A hypernotion system HS is a 4-tuple (M, V, Rm, H), where H in (M u V)+, the hypernotion (axiom).

"
Class {
	#name : #AFHypernotionGrammar,
	#superclass : #Object,
	#instVars : [
		'hypernotion',
		'startSymbol',
		'productionRules',
		'associatedGrammar',
		'firstSet',
		'parseTable'
	],
	#category : #'FisherParser-Core-Implementation'
}

{ #category : #'instance creation' }
AFHypernotionGrammar class >> metaProductionRules: metaProductionRules nonterminals: nonterminals terminals: terminals startAt: anAFHypernotion [
	^ self basicNew
		initializeHypernotion: anAFHypernotion
			metaProductionRules: metaProductionRules
			nonterminals: nonterminals
			terminals: terminals;
		computeFirstSet;
		yourself
]

{ #category : #testing }
AFHypernotionGrammar >> checkIsLLOne [
	self computeParseTable.
	parseTable
		keysDo: [ :key | 
			(parseTable at: key) size > 1
				ifTrue: [ 
					Error
						signal:
							(String
								streamContents: [ :s | 
									s
										nextPutAll: 'CONFLICT at ';
										print: key;
										nextPutAll: ' -> '.
									(parseTable at: key) 
										do: [ :rule | s print: rule ] 
										separatedBy: [ s space ] ]) ] ]
]

{ #category : #initialization }
AFHypernotionGrammar >> computeFirstSet [
	| previousSize |
	[ 	previousSize := firstSet size.
		productionRules do: [ :rule | firstSet at: rule head putAll: (firstSet firstOf: rule body) ].
		previousSize = firstSet size ] whileFalse
]

{ #category : #initialization }
AFHypernotionGrammar >> computeParseTable [
	" compute parse table using first set. then you can test if there's a conflict "

	productionRules
		do: [ :rule | 
			(associatedGrammar terminals intersection: (firstSet firstOf: rule body))
				do: [ :terminal | 
					parseTable 
						at: (OrderedPair first: rule head second: terminal) 
						put: rule ] ]
]

{ #category : #'inspector extensions' }
AFHypernotionGrammar >> gtDisplayOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPut: $(.
	hypernotion gtDisplayOn: aStream.
	aStream nextPut: $)
]

{ #category : #'inspector extensions' }
AFHypernotionGrammar >> gtInspectorParseTableIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ composite table
		title: [ 'Parse Table' ];
		display: [ parseTable keys ];
		column: '(Nonterminal, terminal)'
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each ];
		send: [ :each | parseTable at: each ];
		showOnly: 50;
		yourself
]

{ #category : #'inspector extensions' }
AFHypernotionGrammar >> gtInspectorProductionRulesIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ composite table
		title: [ 'Production Rules' ];
		display: [ productionRules asArray ];
		column: 'Production Rule' evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each ];
		send: [ :each | each ];
		showOnly: 50;
		yourself
]

{ #category : #initialization }
AFHypernotionGrammar >> initialize [
	firstSet := MultiValuedDictionary dictionary: Dictionary collection: Set.
	parseTable := MultiValuedDictionary dictionary: Dictionary collection: Set
]

{ #category : #initialization }
AFHypernotionGrammar >> initializeHypernotion: aHypernotion metaProductionRules: metaProductionRules nonterminals: nonterminals terminals: terminals [
	self initialize.
	hypernotion := aHypernotion.
	startSymbol := hypernotion asNonterminal.
	productionRules := 
		(SinglyLinkedList with: 
				(NCProductionRule 
					head: startSymbol 
					body: (hypernotion buildBodyOf: nonterminals)))
			addAll: metaProductionRules;
			yourself.
	associatedGrammar := JEGrammar
		productionRules: productionRules
		nonterminals: (nonterminals copyWith: startSymbol)
		terminals: terminals
		startNonterminal: startSymbol.
	associatedGrammar nonterminals do: [ :each | firstSet at: each putAll: #() ]
]

{ #category : #public }
AFHypernotionGrammar >> match: aProtonotion [
	"	a hypernotion match a protonotion, you need the relative substitution. "

	^ [ (associatedGrammar parseTree: aProtonotion asString) substitutionsOf: hypernotion ]
		on: JEFailure
		do: [ AFSubstitution noSolution ]
]

{ #category : #testing }
AFHypernotionGrammar >> matchesEmptyProtonotion [
	^ (firstSet at: startSymbol) includes: #epsilon
]

{ #category : #printing }
AFHypernotionGrammar >> printOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPut: $(;
		print: hypernotion;
		nextPut: $)
]

{ #category : #printing }
AFHypernotionGrammar >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]

{ #category : #public }
AFHypernotionGrammar >> startSymbolFirstSet [
	^ firstSet at: startSymbol
]
