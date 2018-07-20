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
		'firstSet'
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

{ #category : #initialization }
AFHypernotionGrammar >> computeFirstSet [
	| previousSize |
	[ 	previousSize := firstSet size.
		productionRules do: [ :rule | firstSet at: rule head putAll: (firstSet firstOf: rule body) ].
		previousSize = firstSet size ] whileFalse
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
	firstSet := MultiValuedDictionary dictionary: Dictionary collection: Set
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
