"
a hyper rule used by the algorithm.

allows
	- to create a dotted hyper rule of myself.
	- to substitute metanotions and result on another hyper rule

"
Class {
	#name : #AFHyperRule,
	#superclass : #Object,
	#instVars : [
		'head',
		'body'
	],
	#category : #'FisherParser-Core-Implementation'
}

{ #category : #'instance creation' }
AFHyperRule class >> head: anAFHypernotion body: anAFHypernotionCollection [
	^ self basicNew
		initializeHead: anAFHypernotion body: anAFHypernotionCollection;
		yourself
]

{ #category : #'instance creation' }
AFHyperRule class >> head: firstAFHypernotion bodyWith: secondAFHypernotion [
	^ self basicNew
		initializeHead: firstAFHypernotion body: {secondAFHypernotion};
		yourself
]

{ #category : #'instance creation' }
AFHyperRule class >> headWith: aNotion body: anAFHypernotionCollection [
	^ self basicNew
		initializeHead: (AFHypernotion with: aNotion) body: anAFHypernotionCollection;
		yourself
]

{ #category : #'instance creation' }
AFHyperRule class >> headWith: aNotion bodyWith: anAFHypernotion [
	^ self basicNew
		initializeHead: (AFHypernotion with: aNotion) body: {anAFHypernotion};
		yourself
]

{ #category : #'instance creation' }
AFHyperRule class >> headWithAll: aNotionCollection body: anAFHypernotionCollection [
	^ self basicNew
		initializeHead: (AFHypernotion withAll: aNotionCollection) body: anAFHypernotionCollection;
		yourself
]

{ #category : #'instance creation' }
AFHyperRule class >> headWithAll: aNotionCollection bodyWith: anAFHypernotion [
	^ self basicNew
		initializeHead: (AFHypernotion withAll: aNotionCollection) body: {anAFHypernotion};
		yourself
]

{ #category : #comparing }
AFHyperRule >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].
	self class  == anObject class
		ifFalse: [ ^ false ].
	head = anObject head
		ifFalse: [ ^ false ].
	body size == anObject body size
		ifFalse: [ ^ false ].
	body
		with: anObject body
		do: [ :first :second | 
			first = second
				ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #accessing }
AFHyperRule >> apply: aSubstitution [
	^ self class
			head: (head apply: aSubstitution)
			body: (body collect: [ :each | each apply: aSubstitution ])
]

{ #category : #accessing }
AFHyperRule >> body [
	^ body
]

{ #category : #private }
AFHyperRule >> bodyOccurrencesOf: aNotion [
	| tally |
	tally := 0.
	body do: [ :hn | tally := tally + (hn occurrencesOf: aNotion) ].
	^ tally
]

{ #category : #accessing }
AFHyperRule >> dotAtBeginning [
	^ AFDottedHyperRule atTheBeginningOf: self
]

{ #category : #accessing }
AFHyperRule >> dotAtEnd [
	^ AFDottedHyperRule atTheEndOf: self
]

{ #category : #comparing }
AFHyperRule >> hash [
	| hash |
	hash := (self class hash + head hash) hashMultiply.
	body do: [ :each | hash := (hash + each hash) hashMultiply ].
	^ hash
]

{ #category : #accessing }
AFHyperRule >> head [
	^ head
]

{ #category : #initialization }
AFHyperRule >> initializeHead: aHypernotion body: aHypernotionCollection [
	self initialize.
	head := aHypernotion.
	body := aHypernotionCollection
]

{ #category : #testing }
AFHyperRule >> isEpsilon [
	^ body isEmpty
]

{ #category : #'testing - boundness' }
AFHyperRule >> isLRType [
	" A hyper rule is of the type LR iif it is both left-bound and right-bound. "

	^ self isLeftBound and: [ self isRightBound ]
]

{ #category : #'testing - boundness' }
AFHyperRule >> isLType [
	" A hyper rule is of the type L iif it is left-bound but not right-bound. "

	^ self isLeftBound and: [ self isRightBound not ]
]

{ #category : #'testing - boundness' }
AFHyperRule >> isLeftBound [
	" left-bound if for all M in metanotions:
		((head occurrencesOf: M) ~= 0) implies that ((body occurrencesOf: M) ~= 0) "

	| metanotions |
	metanotions := Set new.
	metanotions addAll: head metanotions.
	body do: [ :hn | metanotions addAll: hn metanotions ].
	^ metanotions isEmpty
		ifTrue: [ false ]
		ifFalse: [ 
			metanotions
				do: [ :m | 
					(head occurrencesOf: m) ~= 0
						ifTrue: [ (self bodyOccurrencesOf: m) ~= 0
								ifFalse: [ ^ false ] ] ].
			true ]
]

{ #category : #'testing - boundness' }
AFHyperRule >> isRType [
	" A hyper rule is of the type R iif it is right-bound but not left-bound. "

	^ self isRightBound and: [ self isLeftBound not ]
]

{ #category : #testing }
AFHyperRule >> isRepresentation [
	"head is metanotion free and the body is a terminal"

	^ head isProtonotion and: [ body size = 1 and: [ body first isTerminal ] ]
]

{ #category : #'testing - boundness' }
AFHyperRule >> isRightBound [
	" right-bound if for all M in metanotions:
		((body occurrencesOf: M) ~= 0) implies that ((head occurrencesOf: M) ~= 0) "

	| metanotions |
	metanotions := Set new.
	metanotions addAll: head metanotions.
	body do: [ :hn | metanotions addAll: hn metanotions ].
	^ metanotions isEmpty
		ifTrue: [ false ]
		ifFalse: [ 
			metanotions
				do: [ :m | 
					(self bodyOccurrencesOf: m) ~= 0
						ifTrue: [ (head occurrencesOf: m) ~= 0
								ifFalse: [ ^ false ] ] ].
			true ]
]

{ #category : #testing }
AFHyperRule >> isStrict [
	" if this hyper rule is a production rule that belongs to the strict language.
	it has 
	- notions (nonterminals, for which a production rule can be derived)
	- a symbol (a terminal symbol)
	- empty, or
	- some other protonotion (for which no production rule can be derived),
		which is then said to be a 'blind alley'. "

	| metanotions |
	metanotions := Set new.
	metanotions addAll: head metanotions.
	body do: [ :hn | metanotions addAll: hn metanotions ].
	^ metanotions isEmpty
]

{ #category : #'testing - boundness' }
AFHyperRule >> isXType [
	" A hyper rule is of the type X iif it is neither left-bound nor right-bound. "

	^ self isLeftBound not and: [ self isRightBound not ]
]

{ #category : #printing }
AFHyperRule >> printOn: aStream [
	aStream
		print: head;
		nextPutAll: ': '.
	body do: [ :hn | aStream print: hn ] separatedBy: [ aStream nextPutAll: ', ' ].
	aStream nextPut: $.
]

{ #category : #printing }
AFHyperRule >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]

{ #category : #'initialize-release' }
AFHyperRule >> release [
	head := body := nil.
	super release
]
