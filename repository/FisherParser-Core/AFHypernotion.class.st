"
a hypernotion used by the algorithm.

"
Class {
	#name : #AFHypernotion,
	#superclass : #Object,
	#instVars : [
		'notions',
		'metanotions',
		'protonotions',
		'strictSyntax',
		'vwGrammar',
		'matcher'
	],
	#category : #'FisherParser-Core-Implementation'
}

{ #category : #'instance creation' }
AFHypernotion class >> belongsTo: aVWGrammar withAll: aNotionCollection [
	^ self basicNew
		initializeNotions: aNotionCollection;
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

{ #category : #accessing }
AFHypernotion >> apply: aSubstitution [
	^ (self class withAll: (notions collect: [ :notion | notion apply: aSubstitution ]))
		belongsTo: vwGrammar;
		yourself
]

{ #category : #accessing }
AFHypernotion >> belongsTo: aVWGrammar [ 
	vwGrammar := aVWGrammar
	
]

{ #category : #initialization }
AFHypernotion >> createMatcherUsing: aMatcherCreator [
	^ self isHypernotion
		ifTrue: [ aMatcherCreator createHypernotionMatcherFor: self ]
		ifFalse: [ 
			self isProtonotion
				ifTrue: [ aMatcherCreator createProtonotionMatcherFor: self ]
				ifFalse: [ 
					self isTerminal
						ifTrue: [ aMatcherCreator createTerminalMatcherFor: self ]
						ifFalse: [ self error ] ] ]
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
AFHypernotion >> initialize [
	metanotions := Set new.
	protonotions := Set new.
	vwGrammar := nil.
	matcher := nil
]

{ #category : #initialization }
AFHypernotion >> initializeNotions: aNotionCollection [
	self initialize.
	notions := aNotionCollection.
	notions 
		do: [ :each | 
				each isMetanotion ifTrue: [ metanotions add: each ].
				each isProtonotion ifTrue: [ protonotions add: each ] ].
	strictSyntax := String streamContents: [ :s | notions do: [ :each | each printOn: s ] ]
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
			and: [ notions isNotEmpty and: [ notions allSatisfy: [ :notion | notion isProtonotion ] ] ]
]

{ #category : #testing }
AFHypernotion >> isTerminal [
	^ metanotions isEmpty 
			and: [ notions isNotEmpty and: [ notions allSatisfy: [ :notion | notion isTerminal ] ] ]
]

{ #category : #matching }
AFHypernotion >> match: aHypernotion [
	matcher ifNil: [ matcher := vwGrammar createMatcherFor: self ].
	^ matcher match: aHypernotion
]

{ #category : #matching }
AFHypernotion >> matches: aCharacter [ 
	^ notions first matches: aCharacter 
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

{ #category : #accessing }
AFHypernotion >> ortholetters [
	" alphabet used to define protonotions [languageless programming].
	protonotions is a finite vocabulary whose letters are called ortholetters."

	| ortholetters |
	ortholetters := Set new.
	protonotions do: [ :pn | ortholetters addAll: pn letters ].
	^ ortholetters
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
	^ protonotions
]

{ #category : #'initialize-release' }
AFHypernotion >> release [
	notions := metanotions := protonotions := strictSyntax := vwGrammar := matcher := nil.
	super release
]

{ #category : #matching }
AFHypernotion >> strictMatch: aProtonotionHypernotion [
	" a protonotion match a protonotion, therefore the substitution is empty.
	 optimize for efficiency. "

	strictSyntax size = aProtonotionHypernotion strictSyntax size
		ifFalse: [ ^ AFSubstitution noSolution ].
	1 to: strictSyntax size do: [ :index | 
		(strictSyntax at: index) = (aProtonotionHypernotion strictSyntax at: index)
			ifFalse: [ ^ AFSubstitution noSolution ] ].
	^ AFSubstitution emptySolution
]

{ #category : #accessing }
AFHypernotion >> strictSyntax [
	^ strictSyntax
]
