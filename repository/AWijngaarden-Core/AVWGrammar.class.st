"
Adriaan ""Aad"" van Wijngaarden (2 November 1916 – 7 February 1987).
https://en.wikipedia.org/wiki/Adriaan_van_Wijngaarden

a Van Wijngaarden grammar (also vW-grammar or W-grammar) is a two-level grammar which provides a technique to define potentially infinite context-free grammars in a finite number of rules. 
https://en.wikipedia.org/wiki/Van_Wijngaarden_grammar

"
Class {
	#name : #AVWGrammar,
	#superclass : #Object,
	#instVars : [
		'metanotions',
		'protonotions',
		'hypernotions',
		'terminals',
		'metaRules',
		'hyperRules',
		'startNotion'
	],
	#category : #'AWijngaarden-Core'
}

{ #category : #'instance creation' }
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

{ #category : #'inspector extensions' }
AVWGrammar >> gtInspectorHyperRulesIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ composite table
		title: [ 'Hyper Rules' ];
		display: [ hyperRules ];
		column: 'Hyper Rule'
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each ];
		showOnly: 50;
		yourself
]

{ #category : #'inspector extensions' }
AVWGrammar >> gtInspectorMetaRulesIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ composite table
		title: [ 'Meta Rules' ];
		display: [ metaRules ];
		column: 'Meta Rule' evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each ];
		showOnly: 50;
		yourself
]

{ #category : #accessing }
AVWGrammar >> hyperRules [
	^ hyperRules
]

{ #category : #accessing }
AVWGrammar >> hyperRulesSize [
	^ hyperRules size
]

{ #category : #accessing }
AVWGrammar >> hypernotions [
	^ hypernotions
]

{ #category : #initialization }
AVWGrammar >> initializeMetanotions: metanotionSet protonotions: protonotionSet hypernotions: hypernotionSet terminals: terminalSet metaRules: metaRuleCollection hyperRules: hyperRuleCollection startNotion: aHypernotion [
	self initialize.
	metanotions := metanotionSet.
	protonotions := protonotionSet.
	hypernotions := hypernotionSet.
	terminals := terminalSet.
	metaRules := metaRuleCollection.
	hyperRules := hyperRuleCollection.
	startNotion := aHypernotion
]

{ #category : #accessing }
AVWGrammar >> metaRules [
	^ metaRules
]

{ #category : #accessing }
AVWGrammar >> metaRulesSize [
	^ metaRules size
]

{ #category : #accessing }
AVWGrammar >> metanotions [
	^ metanotions 
]

{ #category : #printing }
AVWGrammar >> printOn: aStream [
	aStream
		nextPutAll: self className;
		nextPut: $(;
		print: startNotion;
		nextPut: $)
]

{ #category : #printing }
AVWGrammar >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]

{ #category : #accessing }
AVWGrammar >> protonotions [
	^ protonotions
]

{ #category : #accessing }
AVWGrammar >> startNotion [
	^ startNotion
]

{ #category : #accessing }
AVWGrammar >> terminals [
	^ terminals 
]
