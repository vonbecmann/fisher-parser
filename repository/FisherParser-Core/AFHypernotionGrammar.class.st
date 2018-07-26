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
		'associatedGrammar',
		'firstSet',
		'parseTable',
		'followSet'
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
		yourself
]

{ #category : #testing }
AFHypernotionGrammar >> checkIsLLOne [
	self 
		computeFirstSet;
		computeFollowSet;
		computeParseTable.
	
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

{ #category : #private }
AFHypernotionGrammar >> computeFirstSet [
	| previousSize |
	[ 	previousSize := firstSet size.
		associatedGrammar productionRules 
			do: [ :rule | 
				firstSet 
					at: rule head 
					putAll: (firstSet firstOf: rule body) ].
		previousSize = firstSet size ] whileFalse
]

{ #category : #private }
AFHypernotionGrammar >> computeFollowSet [
	| previousSize symbolFollowSet rest restFirstSet |
	[ previousSize := followSet size.
	associatedGrammar productionRules
		do: [ :rule | 
			rule body
				withIndexDo: [ :symbol :index | 
					symbol isNonterminal
						ifTrue: [ 
							symbolFollowSet := Set new.
							rest := rule body copyFrom: index + 1 to: rule body size.
							rest isEmpty
								ifTrue: [ symbolFollowSet addAll: (followSet at: rule head) ]
								ifFalse: [ 
									restFirstSet := firstSet firstOf: rest.
									(restFirstSet includes: #epsilon)
										ifTrue: [ symbolFollowSet addAll: (followSet at: rule head) ].
									symbolFollowSet addAll: (restFirstSet copyWithout: #epsilon) ].
							followSet at: symbol putAll: symbolFollowSet ] ] ].
	previousSize = followSet size ] whileFalse
]

{ #category : #private }
AFHypernotionGrammar >> computeParseTable [
	" compute parse table using first set and follow test. 
	  then you can test if there's a conflict "

	associatedGrammar productionRules
		do: [ :rule | 
			| bodyFirstSet |
			bodyFirstSet := firstSet firstOf: rule body.
			(associatedGrammar terminals intersection: bodyFirstSet)
				do: [ :terminal | 
					parseTable 
						at: (OrderedPair first: rule head second: terminal) 
						put: rule ].
			(bodyFirstSet includes: #epsilon)
				ifTrue: [ 
					(associatedGrammar terminals intersection: (followSet at: rule head))
						do: [ :terminal | 
							parseTable 
								at: (OrderedPair first: rule head second: terminal) 
								put: rule ] ] ]
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
	^ associatedGrammar gtInspectorProductionRulesIn: composite
]

{ #category : #initialization }
AFHypernotionGrammar >> initialize [
	firstSet := MultiValuedDictionary dictionary: Dictionary collection: Set.
	followSet := MultiValuedDictionary dictionary: Dictionary collection: Set.
	parseTable := MultiValuedDictionary dictionary: Dictionary collection: Set
]

{ #category : #initialization }
AFHypernotionGrammar >> initializeHypernotion: aHypernotion metaProductionRules: metaProductionRules nonterminals: nonterminals terminals: terminals [
	self initialize.
	hypernotion := aHypernotion.
	startSymbol := hypernotion asNonterminal.
	associatedGrammar := JEGrammar
		productionRules:
			((SinglyLinkedList
				with: 	(NCProductionRule 
							head: startSymbol 
							body: (hypernotion buildBodyOf: nonterminals)))
				addAll: metaProductionRules;
				yourself)
		nonterminals: (nonterminals copyWith: startSymbol)
		terminals: terminals
		startNonterminal: startSymbol.
	associatedGrammar nonterminals 
		do: [ :each | 
			firstSet at: each putAll: #().
			followSet at: each putAll: #() ].
	followSet at: startSymbol put: #endmarker
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
