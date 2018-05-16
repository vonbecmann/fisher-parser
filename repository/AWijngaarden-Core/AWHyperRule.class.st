"
The second set of rules in a W-grammar is called the *hyper-rules*.
The hyper-rules ""stand for"" some possibly infinite set of production
rules. 

- A ""hyper-rule"" consists of the following items, in order:
  - a nonempty hypernotion H;
  - a colon;
  - a nonempty sequence of ""hyperalternatives"" separated by semicolons;
  - a point

- A ""hyperalternative"" is a nonempty sequence of hypernotions separated by commas.

"
Class {
	#name : #AWHyperRule,
	#superclass : #Object,
	#instVars : [
		'head',
		'body'
	],
	#category : #'AWijngaarden-Core'
}

{ #category : #'instance creation' }
AWHyperRule class >> head: aHypernotion [
	^ self basicNew
		initializeHead: aHypernotion body: {};
		yourself
]

{ #category : #'instance creation' }
AWHyperRule class >> head: aHypernotion body: aHypernotionCollection [
	^ self basicNew
		initializeHead: aHypernotion body: aHypernotionCollection;
		yourself
]

{ #category : #comparing }
AWHyperRule >> = anObject [
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
AWHyperRule >> body [
	^ body
]

{ #category : #comparing }
AWHyperRule >> hash [
	| hash |
	hash := (self class hash + head hash) hashMultiply.
	body do: [ :each | hash := (hash + each hash) hashMultiply ].
	^ hash
]

{ #category : #accessing }
AWHyperRule >> head [
	^ head
]

{ #category : #initialization }
AWHyperRule >> initializeHead: aHypernotion body: aHypernotionCollection [
	self initialize.
	head := aHypernotion.
	body := aHypernotionCollection
]

{ #category : #testing }
AWHyperRule >> isRepresentation [
	^ body size = 1 and: [ body first isTerminal ]
]

{ #category : #printing }
AWHyperRule >> printOn: aStream [
	aStream
		print: head;
		nextPutAll: ': '.
	body do: [ :hn | aStream print: hn ] separatedBy: [ aStream nextPutAll: ', ' ].
	aStream nextPut: $.
]
