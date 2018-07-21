"
a hypernotion used by the algorithm.

"
Class {
	#name : #AFHypernotion,
	#superclass : #Object,
	#instVars : [
		'notions',
		'metanotions',
		'grammar',
		'metaGrammar',
		'backwardCrossReferences',
		'forwardCrossReferences'
	],
	#category : #'FisherParser-Core-Implementation'
}

{ #category : #'instance creation' }
AFHypernotion class >> belongsTo: aVWGrammar with: aNotion [
	^ (self with: aNotion)
		belongsTo: aVWGrammar;
		yourself
]

{ #category : #'instance creation' }
AFHypernotion class >> belongsTo: aVWGrammar withAll: aNotionCollection [
	^ (self withAll: aNotionCollection)
			belongsTo: aVWGrammar;
			yourself
]

{ #category : #'instance creation' }
AFHypernotion class >> belongsTo: aVWGrammar withAllNotionsFrom: anotherHypernotion [
	^ (self withAll: anotherHypernotion notions)
			belongsTo: aVWGrammar;
			yourself
]

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

{ #category : #'cross references' }
AFHypernotion >> addBackwardCrossReference: anAFHyperRule [ 
	backwardCrossReferences add: anAFHyperRule 
]

{ #category : #'cross references' }
AFHypernotion >> addForwardCrossReference: anAFHyperRule [
	forwardCrossReferences add: anAFHyperRule
]

{ #category : #accessing }
AFHypernotion >> apply: aSubstitution [
	^ (self class withAll: (notions collect: [ :notion | notion apply: aSubstitution ]))
		belongsTo: metaGrammar;
		backwardCrossReferences: backwardCrossReferences;
		forwardCrossReferences: forwardCrossReferences;
		yourself
]

{ #category : #accessing }
AFHypernotion >> asNonterminal [
	^ NCNonterminal named: self printString
]

{ #category : #'cross references' }
AFHypernotion >> backwardCrossReferences: aHyperRuleCollection [ 
	backwardCrossReferences := aHyperRuleCollection
]

{ #category : #'cross references' }
AFHypernotion >> backwardCrossReferencesDo: aBlock [
	backwardCrossReferences do: aBlock
]

{ #category : #accessing }
AFHypernotion >> belongsTo: aMetaGrammar [ 
	metaGrammar := aMetaGrammar
	
]

{ #category : #accessing }
AFHypernotion >> buildBodyOf: symbols [
	"build body of symbols using those given as parameters"

	^ Array
		streamContents: [ :s | 
			notions
				do: [ :each | 
					each isMetanotion
						ifTrue: [ s nextPut: (symbols detect: [ :symbol | symbol = each ]) ].
					each isProtonotion
						ifTrue: [ s nextPutAll: (each buildBodyOf: symbols) ].
					each isTerminal
						ifTrue: [ s nextPut: (symbols detect: [ :symbol | symbol = each ]) ] ] ]
]

{ #category : #accessing }
AFHypernotion >> firstSet [
	^ self grammar startSymbolFirstSet
]

{ #category : #'cross references' }
AFHypernotion >> forwardCrossReferences [
	^ forwardCrossReferences
]

{ #category : #'cross references' }
AFHypernotion >> forwardCrossReferences: aHyperRuleCollection [ 
	forwardCrossReferences := aHyperRuleCollection
]

{ #category : #'cross references' }
AFHypernotion >> forwardCrossReferencesDo: aBlock [
	forwardCrossReferences do: aBlock
]

{ #category : #accessing }
AFHypernotion >> grammar [
	^ grammar ifNil: [ grammar := metaGrammar startAt: self ]
]

{ #category : #'inspector extensions' }
AFHypernotion >> gtDisplayOn: aStream [
	notions 
		do: [ :each | each printOn: aStream ] 
		separatedBy: [ aStream space ]
]

{ #category : #'inspector extensions' }
AFHypernotion >> gtInspectorBackwardCrossReferencesIn: composite [
	<gtInspectorPresentationOrder: 2>
	^ composite list
		title: [ 'Backward X-Ref' ];
		display: [ backwardCrossReferences ];
		format: [ :each | GTObjectPrinter new asTruncatedTextFrom: each ];
		showOnly: 50;
		yourself
]

{ #category : #'inspector extensions' }
AFHypernotion >> gtInspectorForwardCrossReferencesIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ composite list
		title: [ 'Forward X-Ref' ];
		display: [ forwardCrossReferences ];
		format: [ :each | GTObjectPrinter new asTruncatedTextFrom: each ];
		showOnly: 50;
		yourself
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
AFHypernotion >> initialize [
	metanotions := Set new.
	metaGrammar := nil.
	grammar := nil.
	backwardCrossReferences := Set new.
	forwardCrossReferences := Set new
]

{ #category : #initialization }
AFHypernotion >> initializeNotions: aNotionCollection [
	self initialize.
	notions := aNotionCollection.
	notions
		do: [ :each | 
			each isMetanotion
				ifTrue: [ metanotions add: each ] ]
]

{ #category : #testing }
AFHypernotion >> isEmpty [
	^ notions isEmpty
]

{ #category : #testing }
AFHypernotion >> isHypernotion [
	^ notions isEmpty or: [ metanotions isNotEmpty ]
]

{ #category : #testing }
AFHypernotion >> isProtonotion [
	"its metanotion free"

	^ metanotions isEmpty
		and: [ notions isNotEmpty 
					and: [ notions allSatisfy: [ :notion | notion isProtonotion ] ] ]
]

{ #category : #testing }
AFHypernotion >> isStrict [
	^ metanotions isEmpty
]

{ #category : #testing }
AFHypernotion >> isTerminal [
	^ metanotions isEmpty
		and: [ notions isNotEmpty and: [ notions allSatisfy: [ :notion | notion isTerminal ] ] ]
]

{ #category : #matching }
AFHypernotion >> match: aProtonotionHypernotion [
	^ self grammar match: aProtonotionHypernotion
]

{ #category : #matching }
AFHypernotion >> matches: aCharacter [ 
	^ notions first matches: aCharacter 
]

{ #category : #testing }
AFHypernotion >> matchesEmptyProtonotion [
	^ self grammar matchesEmptyProtonotion
]

{ #category : #accessing }
AFHypernotion >> metanotions [
	^ metanotions
]

{ #category : #accessing }
AFHypernotion >> notions [
	^ notions
]

{ #category : #testing }
AFHypernotion >> occurrencesOf: aNotion [ 
	^ notions occurrencesOf: aNotion 
]

{ #category : #printing }
AFHypernotion >> printOn: aStream [
	notions do: [ :each | each printOn: aStream ]
]

{ #category : #printing }
AFHypernotion >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]

{ #category : #'initialize-release' }
AFHypernotion >> release [
	notions := metanotions := metaGrammar := nil.
	grammar := forwardCrossReferences := nil.
	super release
]

{ #category : #matching }
AFHypernotion >> superMatches: anAFHypernotion [
	self isProtonotion
		ifTrue: [ ^ (anAFHypernotion match: self) isSolution ].
	anAFHypernotion isProtonotion
		ifTrue: [ ^ (self match: anAFHypernotion) isSolution ].
	^ (self firstSet intersection: anAFHypernotion firstSet) isNotEmpty
]
