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
AVWGrammar class >> metarules: metaruleArray hyperrules: hyperrulesArray representations: aCollection3 [ 
	| metarules hyperrules |
	metarules := OrderedCollection new.
	metaruleArray 
		collect: [ :each |
				AWMetaProductionRule 
					head: (AWMetanotion named: each first)
					body: (AWHypernotion withAll: (each second collect: [:n | n asNotion ])) ]
		thenDo: [ :each | metarules add: each ].
	hyperrules := OrderedCollection new.
	hyperrulesArray 
		collect: [ :hrule |
			AWHyperRule
				head: (AWHypernotion withAll: (hrule first collect: [:n | n asNotion ]))
				body: (hrule second 
							collect: [ :hn | AWHypernotion withAll: (hn collect: [:n | n asNotion ])])
			 ]
		thenDo: [:hrule | hyperrules add: hrule ].
	^ self basicNew initializeMetaRules: metarules andHyperrules: hyperrules 
]

{ #category : #accessing }
AVWGrammar >> hyperrulesSize [
	^ hyperrules size
]

{ #category : #initialization }
AVWGrammar >> initializeMetaRules: aCollection andHyperrules: aCollection2 [ 
	self initialize.
	metarules := aCollection.
	hyperrules := aCollection2 
]

{ #category : #accessing }
AVWGrammar >> metarulesSize [
	^ metarules size
]
