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
		'metarules',
		'hyperrules',
		'terminals'
	],
	#category : #'AWijngaarden-Core'
}

{ #category : #'instance creation' }
AVWGrammar class >> metarules: metaruleArray hyperrules: hyperrulesArray representations: terminalNotionToRepresentationList [
	| metanotions terminals metarules hyperrules |
	metanotions := Set new.
	metaruleArray do: [ :each | metanotions add: (AWMetanotion named: each first) ].
	terminals := Set new.
	terminalNotionToRepresentationList do: [ :assoc | terminals add: assoc value ].
	metarules := OrderedCollection new.
	metaruleArray
		collect: [ :each | 
			AWMetaProductionRule
				head: (AWMetanotion named: each first)
				body: (AWHypernotion withAll: (each second collect: [ :n | n asNotion ])) ]
		thenDo: [ :metarule | metarules add: metarule ].
	hyperrules := OrderedCollection new.
	hyperrulesArray
		collect: [ :each | 
			AWHyperRule
				head: (AWHypernotion withAll: (each first collect: [ :n | n asNotion ]))
				body: (each second collect: [ :hn | AWHypernotion withAll: (hn collect: [ :n | n asNotion ]) ]) ]
		thenDo: [ :hrule | hyperrules add: hrule ].
	terminalNotionToRepresentationList
		collect: [ :assoc | 
			AWHyperRule
				head: (AWHypernotion withAll: (assoc key collect: [ :n | n asNotion ]))
				body: {(AWHypernotion with: assoc value)} ]
		thenDo: [ :hrule | hyperrules add: hrule ].
	^ self basicNew
		initializeMetanotions: metanotions 
		metarules: metarules 
		hyperrules: hyperrules
		terminals: terminals;
		yourself
]

{ #category : #'inspector extensions' }
AVWGrammar >> gtInspectorHyperRulesIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ composite list
		title: [ 'Hyper Rules' ];
		display: [ hyperrules ];
		format: [ :each | GTObjectPrinter new asTruncatedTextFrom: each ];
		showOnly: 50;
		yourself
]

{ #category : #'inspector extensions' }
AVWGrammar >> gtInspectorMetaRulesIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ composite list
		title: [ 'Meta Rules' ];
		display: [ metarules ];
		format: [ :each | GTObjectPrinter new asTruncatedTextFrom: each ];
		showOnly: 50;
		yourself
]

{ #category : #'inspector extensions' }
AVWGrammar >> gtInspectorMetanotionsIn: composite [
	<gtInspectorPresentationOrder: 2>
	^ composite list
		title: [ 'Metanotions' ];
		display: [ metanotions ];
		format: [ :each | GTObjectPrinter new asTruncatedTextFrom: each ];
		showOnly: 50;
		yourself
]

{ #category : #accessing }
AVWGrammar >> hyperrulesSize [
	^ hyperrules size
]

{ #category : #initialization }
AVWGrammar >> initializeMetanotions: metanotionSet metarules: metaruleCollection hyperrules: hyperruleCollection terminals: terminalSet [
	self initialize.
	metanotions := metanotionSet.
	metarules := metaruleCollection.
	hyperrules := hyperruleCollection.
	terminals := terminalSet
]

{ #category : #accessing }
AVWGrammar >> metanotionsSize [
	^ metanotions size
]

{ #category : #accessing }
AVWGrammar >> metarulesSize [
	^ metarules size
]

{ #category : #accessing }
AVWGrammar >> terminalsSize [
	^ terminals size
]
