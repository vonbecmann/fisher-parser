"
a hypernotion used by the algorithm.

"
Class {
	#name : #AFHypernotion,
	#superclass : #Object,
	#instVars : [
		'notions',
		'vwGrammar',
		'unification'
	],
	#category : #'FisherParser-Core-Implementation'
}

{ #category : #'instance creation' }
AFHypernotion class >> empty [
	^ self new
]

{ #category : #'instance creation' }
AFHypernotion class >> new [
	^ self basicNew initializeNotions: #()
]

{ #category : #'instance creation' }
AFHypernotion class >> with: aNotion [
	^ self basicNew initializeNotions: (Array with: aNotion)
]

{ #category : #'instance creation' }
AFHypernotion class >> withAll: aNotionCollection [
	^ self basicNew
		initializeNotions: aNotionCollection;
		yourself
]

{ #category : #comparing }
AFHypernotion >> = anObject [
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

{ #category : #accessing }
AFHypernotion >> apply: aSubstitution [
	^ (self class
			withAll:
				(notions
					collect: [ :notion | 
							notion isMetanotion
								ifTrue: [ aSubstitution at: notion ]
								ifFalse: [ notion ] ]))
		belongsTo: vwGrammar;
		yourself
]

{ #category : #converting }
AFHypernotion >> asStrictString [
	^ String streamContents: [ :s | notions do: [ :each | each printOn: s ] ]
]

{ #category : #accessing }
AFHypernotion >> belongsTo: aVWGrammar [ 
	vwGrammar := aVWGrammar
	
]

{ #category : #enumerating }
AFHypernotion >> do: aBlock [ 
	notions do: aBlock 
]

{ #category : #accessing }
AFHypernotion >> first [
	^ notions first
]

{ #category : #'inspector extensions' }
AFHypernotion >> gtInspectorNotionsIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ composite list
		title: [ notions size asString, ' notions' ];
		display: [ notions ];
		format: [ :each | GTObjectPrinter new asTruncatedTextFrom: each ];
		showOnly: 50;
		yourself
]

{ #category : #comparing }
AFHypernotion >> hash [
	| hash |
	hash := self class hash.
	notions do: [ :each | hash := (hash + each hash) hashMultiply ].
	^ hash
]

{ #category : #initialization }
AFHypernotion >> initializeNotions: aCollection [
	self initialize.
	notions := aCollection
]

{ #category : #testing }
AFHypernotion >> isEmpty [
	^ notions isEmpty
]

{ #category : #testing }
AFHypernotion >> isHypernotion [
	^ notions isEmpty or: [ notions anySatisfy: [ :notion | notion isMetanotion ] ]
]

{ #category : #testing }
AFHypernotion >> isProtonotion [
	"its metanotion free"

	^ notions isNotEmpty and: [ notions allSatisfy: [ :notion | notion isProtonotion ] ]
]

{ #category : #testing }
AFHypernotion >> isTerminal [
	^ notions isNotEmpty and: [ notions allSatisfy: [ :notion | notion isTerminal ] ]
]

{ #category : #testing }
AFHypernotion >> matches: aCharacter [ 
	^ notions first matches: aCharacter 
]

{ #category : #accessing }
AFHypernotion >> metanotions [
	^ notions select: [ :each | each isMetanotion ]
]

{ #category : #accessing }
AFHypernotion >> notions [
	^ notions
]

{ #category : #printing }
AFHypernotion >> printOn: aStream [
	notions 
		do: [ :each | aStream print: each ] 
		separatedBy: [ aStream space ]
]

{ #category : #printing }
AFHypernotion >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]

{ #category : #accessing }
AFHypernotion >> protonotions [
	^ notions select: [ :each | each isProtonotion ]
]

{ #category : #accessing }
AFHypernotion >> unifyWith: aHypernotion [
	unification ifNil: [ unification := vwGrammar buildUnificationWith: self ].
	^ unification unifyWith: aHypernotion
]
