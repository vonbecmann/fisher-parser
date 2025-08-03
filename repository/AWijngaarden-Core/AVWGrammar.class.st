"
Adriaan ""Aad"" van Wijngaarden (2 November 1916 – 7 February 1987).
https://en.wikipedia.org/wiki/Adriaan_van_Wijngaarden

a Van Wijngaarden grammar (also vW-grammar or W-grammar) is a two-level grammar which provides a technique to define potentially infinite context-free grammars in a finite number of rules. 
https://en.wikipedia.org/wiki/Van_Wijngaarden_grammar

"
Class {
	#name : 'AVWGrammar',
	#superclass : 'Object',
	#instVars : [
		'metanotions',
		'ortholetters',
		'protonotions',
		'hypernotions',
		'terminals',
		'metaRules',
		'hyperRules',
		'hyperRulesHypernotions',
		'startNotion'
	],
	#category : 'AWijngaarden-Core-Public',
	#package : 'AWijngaarden-Core',
	#tag : 'Public'
}

{ #category : 'instance creation' }
AVWGrammar class >> metanotions: metanotionSet protonotions: protonotionSet hypernotions: hypernotionSet terminals: terminalSet metaRules: metaRuleCollection hyperRules: hyperRuleCollection startAt: aHypernotion [

	^ self basicNew
		  initializeMetanotions: metanotionSet
		  protonotions: protonotionSet
		  hypernotions: hypernotionSet
		  terminals: terminalSet
		  metaRules: metaRuleCollection
		  hyperRules: hyperRuleCollection
		  startNotion: aHypernotion;
		  yourself
]

{ #category : 'accessing' }
AVWGrammar >> hyperRuleAt: index [
	^ hyperRules at: index
]

{ #category : 'accessing' }
AVWGrammar >> hyperRuleAtAll: indexArray [
	^ hyperRules atAll: indexArray
]

{ #category : 'accessing' }
AVWGrammar >> hyperRules [
	^ hyperRules
]

{ #category : 'accessing' }
AVWGrammar >> hyperRulesHypernotions [
	" hyperRule's hypernotions "

	^ hyperRulesHypernotions
]

{ #category : 'accessing' }
AVWGrammar >> hyperRulesSize [
	^ hyperRules size
]

{ #category : 'accessing' }
AVWGrammar >> hypernotions [
	^ hypernotions
]

{ #category : 'initialization' }
AVWGrammar >> initializeMetanotions: metanotionSet protonotions: protonotionSet hypernotions: hypernotionSet terminals: terminalSet metaRules: metaRuleCollection hyperRules: hyperRuleCollection startNotion: aHypernotion [
	self initialize.
	metanotions := metanotionSet.
	protonotions := protonotionSet.
	ortholetters := protonotions
		flatCollect: [ :protonotion | protonotion letters ]
		as: Set.
	hypernotions := hypernotionSet.
	terminals := terminalSet.
	metaRules := metaRuleCollection.
	hyperRules := hyperRuleCollection.
	hyperRulesHypernotions := hyperRules collect: [ :each | each head ] as: Set.
	hyperRules do: [ :each | hyperRulesHypernotions addAll: each body ].
	startNotion := aHypernotion
]

{ #category : 'inspector extensions' }
AVWGrammar >> inspectionDefinitionIn: aBuilder [

	<inspectorPresentationOrder: 0 title: 'Definition'>
	^ aBuilder newList
		  display: [ :each | StObjectPrinter asTruncatedTextFrom: each ];
		  items: metaRules , hyperRules;
		  yourself
]

{ #category : 'inspector extensions' }
AVWGrammar >> inspectionHyperRulesIn: aBuilder [

	<inspectorPresentationOrder: 2 title: 'Hyper Rules'>
	^ aBuilder newTable
		  addColumn: (SpStringTableColumn
				   title: 'Hyper Rule'
				   evaluated: [ :each | StObjectPrinter asTruncatedTextFrom: each ]);
		  items: hyperRules;
		  yourself
]

{ #category : 'inspector extensions' }
AVWGrammar >> inspectionMetaRulesIn: aBuilder [

	<inspectorPresentationOrder: 1 title: 'Meta Rules'>
	^ aBuilder newTable
		  addColumn: (SpStringTableColumn
				   title: 'Meta Rule'
				   evaluated: [ :each | StObjectPrinter asTruncatedTextFrom: each ]);
		  items: metaRules;
		  yourself
]

{ #category : 'accessing' }
AVWGrammar >> metaRules [
	^ metaRules
]

{ #category : 'accessing' }
AVWGrammar >> metaRulesSize [
	^ metaRules size
]

{ #category : 'accessing' }
AVWGrammar >> metanotions [

	^ metanotions
]

{ #category : 'accessing' }
AVWGrammar >> ortholetters [
	" alphabet used to define protonotions [languageless programming].
	protonotions is a finite vocabulary whose letters are called ortholetters."

	^ ortholetters
]

{ #category : 'printing' }
AVWGrammar >> printOn: aStream [
	aStream
		nextPutAll: self className;
		nextPut: $(;
		print: startNotion;
		nextPut: $)
]

{ #category : 'printing' }
AVWGrammar >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]

{ #category : 'accessing' }
AVWGrammar >> protonotions [
	^ protonotions
]

{ #category : 'accessing' }
AVWGrammar >> startNotion [
	^ startNotion
]

{ #category : 'accessing' }
AVWGrammar >> terminals [

	^ terminals
]
