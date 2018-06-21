"
- a *hypernotion* is a possibly empty sequence of metanotions and/or protonotions (e.g., *letter ALPHA*)


"
Class {
	#name : #AWHypernotion,
	#superclass : #Object,
	#instVars : [
		'notions'
	],
	#category : #'AWijngaarden-Core'
}

{ #category : #'instance creation' }
AWHypernotion class >> empty [
	^ self new
]

{ #category : #'instance creation' }
AWHypernotion class >> new [
	^ self basicNew initializeNotions: #()
]

{ #category : #'instance creation' }
AWHypernotion class >> with: aNotion [
	^ self basicNew initializeNotions: (Array with: aNotion)
]

{ #category : #'instance creation' }
AWHypernotion class >> withAll: aNotionCollection [
	^ self basicNew
		initializeNotions: aNotionCollection;
		yourself
]

{ #category : #comparing }
AWHypernotion >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].
	self class == anObject class
		ifFalse: [ ^ false ].
	notions size == anObject notions size
		ifFalse: [ ^ false ].
	notions
		with: anObject notions
		do: [ :first :second | 
			first = second
				ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #enumerating }
AWHypernotion >> collect: aBlock [
	^ self class withAll: (notions collect: aBlock)
]

{ #category : #'inspector extensions' }
AWHypernotion >> gtInspectorNotionsIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ composite list
		title: [ notions size asString, ' notions' ];
		display: [ notions ];
		format: [ :each | GTObjectPrinter new asTruncatedTextFrom: each ];
		showOnly: 50;
		yourself
]

{ #category : #comparing }
AWHypernotion >> hash [
	| hash |
	hash := self class hash.
	notions do: [ :each | hash := (hash + each hash) hashMultiply ].
	^ hash
]

{ #category : #initialization }
AWHypernotion >> initializeNotions: aCollection [
	self initialize.
	notions := aCollection
]

{ #category : #testing }
AWHypernotion >> isEmpty [
	^ notions isEmpty
]

{ #category : #testing }
AWHypernotion >> isProtonotion [
	"its metanotion free"

	^ notions isNotEmpty and: [ notions allSatisfy: [ :notion | notion isProtonotion ] ]
]

{ #category : #testing }
AWHypernotion >> isTerminal [
	^ notions isNotEmpty and: [ notions allSatisfy: [ :notion | notion isTerminal ] ]
]

{ #category : #accessing }
AWHypernotion >> metanotions [
	| metanotions |
	metanotions := Set new.
	notions 
		select: [ :each | each isMetanotion ] 
		thenDo: [ :each | metanotions add: each ].
	^ metanotions
]

{ #category : #accessing }
AWHypernotion >> notions [
	^ notions
]

{ #category : #printing }
AWHypernotion >> printOn: aStream [
	notions 
		do: [ :each | aStream print: each ] 
		separatedBy: [ aStream space ]
]

{ #category : #printing }
AWHypernotion >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]

{ #category : #accessing }
AWHypernotion >> protonotions [
	| protonotions |
	protonotions := Set new.
	notions 
		select: [ :each | each isProtonotion ] 
		thenDo: [ :each | protonotions add: each ].
	^ protonotions
]

{ #category : #accessing }
AWHypernotion >> terminals [
	| terminals |
	terminals := Set new.
	notions 
		select: [ :notion | notion isTerminal ] 
		thenDo: [ :notion | terminals add: notion ].
	^ terminals
]
