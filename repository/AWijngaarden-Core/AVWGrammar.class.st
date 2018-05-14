"
vw Grammar.

"
Class {
	#name : #AVWGrammar,
	#superclass : #Object,
	#instVars : [
		'metarules'
	],
	#category : #'AWijngaarden-Core'
}

{ #category : #'instance creation' }
AVWGrammar class >> metarules: metaruleArray hyperrules: aCollection2 representations: aCollection3 [ 
	| metarules |
	metarules := OrderedCollection new.
	metaruleArray 
		collect: [ :each |
				AWMetaProductionRule 
					head: (AWMetanotion named: each first)
					body: (AWHypernotion withAll: (each second collect: [:n | n asNotion ])) ]
		thenDo: [ :each | metarules add: each ].

	^ self basicNew initializeMetaRules: metarules andHyperrules: #()
]

{ #category : #accessing }
AVWGrammar >> hyperrulesSize [
	^ 6
]

{ #category : #initialization }
AVWGrammar >> initializeMetaRules: aCollection andHyperrules: aCollection2 [ 
	self initialize.
	metarules := aCollection.
]

{ #category : #accessing }
AVWGrammar >> metarulesSize [
	^ metarules size
]
