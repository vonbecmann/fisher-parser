"
a hypernotion's grammar. (some called it hypernotion system).


"
Class {
	#name : #AFHypernotionGrammar,
	#superclass : #Object,
	#instVars : [
		'nonterminals',
		'terminals',
		'productionRules',
		'startSymbol',
		'associatedGrammar'
	],
	#category : #'FisherParser-Core-Implementation'
}

{ #category : #'instance creation' }
AFHypernotionGrammar class >> productionRules: productionRuleCollection nonterminals: nonterminalSet terminals: terminalSet startNonterminal: aNonterminal [
	^ self basicNew
		initializeProductionRules: productionRuleCollection
			nonterminals: nonterminalSet
			terminals: terminalSet
			startNonterminal: aNonterminal;
		yourself
]

{ #category : #initialization }
AFHypernotionGrammar >> initializeProductionRules: productionRuleCollection nonterminals: nonterminalSet terminals: terminalSet startNonterminal: aNonterminal [
	self initialize.
	nonterminals := nonterminalSet.
	terminals := terminalSet.
	productionRules := productionRuleCollection.
	startSymbol := aNonterminal.
	associatedGrammar := JEGrammar
		productionRules: productionRules
		nonterminals: nonterminals
		terminals: terminals
		startNonterminal: aNonterminal
]

{ #category : #parsing }
AFHypernotionGrammar >> parseTree: aString [
	^ associatedGrammar parseTree: aString
]
