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
		'associatedGrammar'
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
	self initialize.
	hypernotion := anAFHypernotion.
	productionRules := 
		(SinglyLinkedList 
			with: (NCProductionRule head: startSymbol body: (hypernotion buildBodyOf: nonterminalSet)))
		addAll: productionRuleCollection;
		yourself.
	associatedGrammar := JEGrammar
		productionRules: productionRules
		nonterminals: (nonterminalSet copyWith: startSymbol)
		terminals: terminalSet
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
