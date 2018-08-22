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
		'metaProductionRules'
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
	| firstSet followSet parseTable conflictKeys |
	firstSet := self computeFirstSet.
	followSet := self computeFollowSetUsing: firstSet.
	parseTable := self computeParseTableUsing: firstSet and: followSet.
	conflictKeys := parseTable keys select: [ :key | (parseTable at: key) size > 1 ].
	conflictKeys isEmpty
		ifFalse: [ 
			Error
				signal:
					(String
						streamContents: [ :s | 
							s nextPutAll: 'CONFLICT at '.
							conflictKeys do: [ :key | s print: key ] separatedBy: [ s space ] ]) ]
]

{ #category : #initialization }
AFMetaGrammar >> computeFirstSet [
	| firstSet previousSize |
	firstSet := MultiValuedDictionary dictionary: IdentityDictionary collection: IdentitySet.
	nonterminals do: [ :each | firstSet at: each putAll: #() ].
	[	previousSize := firstSet size.
		metaProductionRules do: [ :rule | firstSet at: rule head putAll: (firstSet firstOf: rule body) ].
	previousSize = firstSet size ] whileFalse.
	^ firstSet
]

{ #category : #initialization }
AFMetaGrammar >> computeFollowSetUsing: firstSet [
	| followSet previousSize symbolFollowSet rest restFirstSet |
	followSet := MultiValuedDictionary dictionary: IdentityDictionary collection: IdentitySet.
	nonterminals do: [ :each | followSet at: each putAll: #() ].
	[ previousSize := followSet size.
	metaProductionRules
		do: [ :rule | 
			rule body
				withIndexDo: [ :symbol :index | 
					symbol isNonterminal
						ifTrue: [ 
							symbolFollowSet := IdentitySet new.
							rest := rule body copyFrom: index + 1 to: rule body size.
							rest isEmpty
								ifTrue: [ symbolFollowSet addAll: (followSet at: rule head) ]
								ifFalse: [ 
									restFirstSet := firstSet firstOf: rest.
									(restFirstSet includes: #epsilon)
										ifTrue: [ symbolFollowSet addAll: (followSet at: rule head) ].
									symbolFollowSet addAll: (restFirstSet copyWithout: #epsilon) ].
							followSet at: symbol putAll: symbolFollowSet ] ] ].
	previousSize = followSet size ] whileFalse.
	^ followSet 
]

{ #category : #initialization }
AFMetaGrammar >> computeParseTableUsing: firstSet and: followSet [
	" compute parse table using first set and follow set. 
	then you can test if there's a conflict "

	| parseTable bodyFirstSet |
	parseTable := MultiValuedDictionary dictionary: Dictionary collection: IdentitySet.
	metaProductionRules
		do: [ :rule | 
			bodyFirstSet := firstSet firstOf: rule body.
			(terminals intersection: bodyFirstSet)
				do: [ :terminal | 
					parseTable 
						at: (OrderedPair first: rule head second: terminal) 
						put: rule ].
			(bodyFirstSet includes: #epsilon)
				ifTrue: [ 
					(terminals intersection: (followSet at: rule head))
						do: [ :terminal | 
							parseTable 
								at: (OrderedPair first: rule head second: terminal) 
								put: rule ] ] ].
	^ parseTable 
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
	metaProductionRules := MultiValuedDictionary dictionary: IdentityDictionary collection: SinglyLinkedList
]

{ #category : #initialization }
AFMetaGrammar >> initializeMetaProductionRules: metaRuleCollection ortholetters: ortholetters [
	self initialize.
	metaRuleCollection do: [ :each | nonterminals add: each head ].
	ortholetters 
		do: [ :letter |
			nonterminals add: (NCNonterminal named: letter).
			terminals add: (NCTerminal character: letter) ].
	metaRuleCollection
		collect: [ :each | 
				NCProductionRule
					head: (nonterminals like: each head)
					body: (each body buildBodyOf: nonterminals) ]
		thenDo: [ :each | metaProductionRules at: each head put: each ].
	ortholetters 
		collect: [ :letter | 
			NCProductionRule
				head: (nonterminals like: (NCNonterminal named: letter))
				body: {(terminals like: (NCTerminal character: letter))} ]
		thenDo: [ :each | metaProductionRules at: each head put: each ]
]

{ #category : #'instance creation' }
AFMetaGrammar >> startAt: aHypernotion [
	" creates a hypernotion's grammar using the metagramar "

	| startSymbol |
	startSymbol := aHypernotion asNonterminal.
	^ JEGrammar
		nonterminals: (nonterminals copyWith: startSymbol)
		terminals: terminals
		productionRules:
			((SinglyLinkedList with: (NCProductionRule head: startSymbol body: (aHypernotion buildBodyOf: nonterminals)))
				addAll: metaProductionRules values;
				yourself)
		startNonterminal: startSymbol
]
