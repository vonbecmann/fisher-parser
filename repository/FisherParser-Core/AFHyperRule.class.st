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

{ #category : #testing }
AFHyperRule >> isLeftBound [
	" left-bound if for all M in metanotions:
		((head occurrencesOf: M) ~= 0) implies that ((body occurrencesOf: M) ~= 0) "

	| metanotions |
	metanotions := Set new.
	metanotions addAll: head metanotions.
	body do: [ :hn | metanotions addAll: hn metanotions ].
	metanotions
		do: [ :m | 
			(head occurrencesOf: m) ~= 0
				ifTrue: [ 
					(self bodyOccurrencesOf: m) ~= 0
						ifFalse: [ ^ false ] ] ].
	^ true
]

{ #category : #testing }
AFHyperRule >> isRepresentation [
	"head is metanotion free and the body is a terminal"

	^ head isProtonotion and: [ body size = 1 and: [ body first isTerminal ] ]
]

{ #category : #testing }
AFHyperRule >> isRightBound [
	" right-bound if for all M in metanotions:
		((body occurrencesOf: M) ~= 0) implies that ((head occurrencesOf: M) ~= 0) "

	| metanotions |
	metanotions := Set new.
	metanotions addAll: head metanotions.
	body do: [ :hn | metanotions addAll: hn metanotions ].
	metanotions
		do: [ :m | 
			(self bodyOccurrencesOf: m) ~= 0
				ifTrue: [ 
					(head occurrencesOf: m) ~= 0
						ifFalse: [ ^ false ] ] ].
	^ true
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
