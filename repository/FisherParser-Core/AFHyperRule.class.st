"
a hyper rule used by the algorithm
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
AFHyperRule class >> head: aHypernotion [
	^ self basicNew
		initializeHead: aHypernotion body: {};
		yourself
]

{ #category : #'instance creation' }
AFHyperRule class >> head: aHypernotion body: aHypernotionCollection [
	^ self basicNew
		initializeHead: aHypernotion body: aHypernotionCollection;
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
AFHyperRule >> body [
	^ body
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
AFHyperRule >> isRepresentation [
	"head is metanotion free and the body is a terminal"

	^ head isProtonotion and: [ body size = 1 and: [ body first isTerminal ] ]
]

{ #category : #printing }
AFHyperRule >> printOn: aStream [
	aStream
		print: head;
		nextPutAll: ': '.
	body do: [ :hn | aStream print: hn ] separatedBy: [ aStream nextPutAll: ', ' ].
	aStream nextPut: $.
]
