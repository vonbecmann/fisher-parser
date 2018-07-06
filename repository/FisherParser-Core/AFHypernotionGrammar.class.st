"
a hypernotion's grammar. (some called it hypernotion system).

use jay earley parser as a pattern matching algorithm.
the hypernotion system is uniquely assignable (u.a.) [wegner]

"
Class {
	#name : #AFHypernotionGrammar,
	#superclass : #Object,
	#instVars : [
		'nonterminals',
		'terminals',
		'productionRules',
		'startSymbol',
		'associatedGrammar',
		'hypernotion'
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
		yourself
]

{ #category : #initialization }
AFHypernotionGrammar >> initialize [
	startSymbol := NCNonterminal named: 'hypernotion-axiom'
]

{ #category : #initialization }
AFHypernotionGrammar >> initializeHypernotion: anAFHypernotion productionRules: productionRuleCollection nonterminals: nonterminalSet terminals: terminalSet [
	| startRule |
	self initialize.
	hypernotion := anAFHypernotion.
	nonterminals := nonterminalSet copyWith: startSymbol.
	terminals := terminalSet.
	startRule := NCProductionRule head: startSymbol body: (hypernotion buildBodyOf: nonterminals).
	productionRules := (SinglyLinkedList with: startRule)
		addAll: productionRuleCollection;
		yourself.
	associatedGrammar := JEGrammar
		productionRules: productionRules
		nonterminals: nonterminals
		terminals: terminals
		startNonterminal: startSymbol
]

{ #category : #public }
AFHypernotionGrammar >> match: aProtonotion [
	"	a hypernotion match a protonotion, you need the relative substitution. "

	^ [ (associatedGrammar parseTree: aProtonotion strictSyntaxString) substitutionsOf: hypernotion ]
		on: JEFailure
		do: [ AFSubstitution noSolution ]
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
