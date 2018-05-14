"
vw Grammar.

"
Class {
	#name : #AVWGrammar,
	#superclass : #Object,
	#instVars : [
		'metarules',
		'hyperrules'
	],
	#category : #'AWijngaarden-Core'
}

{ #category : #'instance creation' }
AVWGrammar class >> metarules: metaruleArray hyperrules: hyperrulesArray representations: terminalNotionToRepresentationList [ 
	| metarules hyperrules |
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
				body: (each second collect: [ :hn | AWHypernotion withAll: (hn collect: [ :n | n asNotion ])])]
		thenDo: [ :hrule | hyperrules add: hrule ].
	terminalNotionToRepresentationList 
		collect: [ :assoc |
			AWHyperRule 
				head: (AWHypernotion withAll: (assoc key collect: [ :n | n asNotion ])) 
				body: {AWHypernotion with: assoc value}]
		thenDo: [ :hrule | hyperrules add: hrule ].
	^ self basicNew initializeMetaRules: metarules andHyperrules: hyperrules 
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

{ #category : #accessing }
AVWGrammar >> hyperrulesSize [
	^ hyperrules size
]

{ #category : #initialization }
AVWGrammar >> initializeMetaRules: metaruleCollection andHyperrules: hyperruleCollection [ 
	self initialize.
	metarules := metaruleCollection.
	hyperrules := hyperruleCollection 
]

{ #category : #accessing }
AVWGrammar >> metarulesSize [
	^ metarules size
]
