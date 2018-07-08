"
a hypernotion's grammar. (some called it hypernotion system).

use jay earley parser as a pattern matching algorithm.
the hypernotion system is uniquely assignable (u.a.) [wegner]

"
Class {
	#name : #AFHypernotionGrammar,
	#superclass : #Object,
	#instVars : [
		'startSymbol',
		'hypernotion',
		'productionRules',
		'associatedGrammar',
		'firstSet'
	],
	#category : #'FisherParser-Core-Implementation'
}

{ #category : #'instance creation' }
AFHypernotionGrammar class >> hypernotion: anAFHypernotion productionRules: productionRuleCollection nonterminals: nonterminalSet terminals: terminalSet [
	^ self basicNew
		initializeHypernotion: anAFHypernotion
			productionRules: productionRuleCollection
			nonterminals: nonterminalSet
			terminals: terminalSet;
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

{ #category : #initialization }
AFHypernotionGrammar >> initialize [
	firstSet := MultiValuedDictionary dictionary: Dictionary collection: Set
]

{ #category : #initialization }
AFHypernotionGrammar >> initializeHypernotion: anAFHypernotion productionRules: productionRuleCollection nonterminals: nonterminalSet terminals: terminalSet [
	self initialize.
	hypernotion := anAFHypernotion.
	startSymbol := NCNonterminal named: hypernotion asString.
	productionRules := 
		(SinglyLinkedList 
			with: (NCProductionRule head: startSymbol body: (hypernotion buildBodyOf: nonterminalSet)))
		addAll: productionRuleCollection;
		yourself.
	associatedGrammar := JEGrammar
		productionRules: productionRules
		nonterminals: (nonterminalSet copyWith: startSymbol)
		terminals: terminalSet
		startNonterminal: startSymbol.
	associatedGrammar 
		nonterminals do: [ :each | firstSet at: each putAll: #() ]
]

{ #category : #public }
AFHypernotionGrammar >> match: aProtonotion [
	"	a hypernotion match a protonotion, you need the relative substitution. "

	^ [ (associatedGrammar parseTree: aProtonotion strictSyntaxString) substitutionsOf: hypernotion ]
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
