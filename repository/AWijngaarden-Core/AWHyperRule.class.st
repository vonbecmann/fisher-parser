"
The second set of rules in a W-grammar is called the *hyper-rules*.
The hyper-rules ""stand for"" some possibly infinite set of production
rules. The format of a hyper-rule is:

a non-empty hypernotion,
followed by a colon,
followed by a sequence of ""hyperalternatives"" separated by semicolons,
followed by a period.

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
AWHyperRule class >> head: aHypernotion body: aHypernotionCollection [
	^ self basicNew initializeHead: aHypernotion body: aHypernotionCollection
]

{ #category : #initialization }
AWHyperRule >> initializeHead: aHypernotion body: aHypernotionCollection [
	self initialize.
	head := aHypernotion.
	body := aHypernotionCollection
]

{ #category : #printing }
AWHyperRule >> printOn: aStream [
	aStream
		print: head;
		nextPutAll: ': '.
	body do: [ :hn | aStream print: hn ] separatedBy: [ aStream nextPutAll: ', ' ].
	aStream nextPut: $.
]
