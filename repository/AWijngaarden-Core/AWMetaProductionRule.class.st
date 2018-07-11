"
The first set of rules in a W-grammar is called the *metaproductions*.
The definition of all metanotions are found in the metaproductions. Each
metaproduction defines a metanotion with the following format:
 that metanotion,
 followed by two colons (the metaproduction symbol),
 followed by a sequence of hypernotions separated by semicolons and ending
 in a period.

Commas are not used in this modified grammar because it is easy to distinguish
between metanotions, the non-terminals; and protonotions, the terminals.

head is a metanotion.
body is a hypernotion.

"
Class {
	#name : #AWMetaProductionRule,
	#superclass : #Object,
	#instVars : [
		'head',
		'body'
	],
	#category : #'AWijngaarden-Core'
}

{ #category : #'instance creation' }
AWMetaProductionRule class >> head: aMetanotion [
	^ self basicNew
		initializeHead: aMetanotion body: AWHypernotion new;
		yourself
]

{ #category : #'instance creation' }
AWMetaProductionRule class >> head: aMetanotion body: aHypernotion [
	^ self basicNew
		initializeHead: aMetanotion body: aHypernotion;
		yourself
]

{ #category : #comparing }
AWMetaProductionRule >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].
	self class == anObject class
		ifFalse: [ ^ false ].
	head = anObject head
		ifFalse: [ ^ false ].
	body = anObject body
		ifFalse: [ ^ false ].
	^ true
]

{ #category : #accessing }
AWMetaProductionRule >> body [
	^ body
]

{ #category : #comparing }
AWMetaProductionRule >> hash [
	^ ((self class hash + head hash) hashMultiply + body hash) hashMultiply
]

{ #category : #accessing }
AWMetaProductionRule >> head [
	^ head
]

{ #category : #initialization }
AWMetaProductionRule >> initializeHead: aMetanotion body: aHypernotion [
	self initialize.
	head := aMetanotion.
	body := aHypernotion
]

{ #category : #accessing }
AWMetaProductionRule >> notions [
	^ (Set with: head)
		addAll: body notions;
		yourself
]

{ #category : #printing }
AWMetaProductionRule >> printOn: aStream [
	aStream
		print: head;
		nextPutAll: ':: ';
		print: body;
		nextPut: $.
]

{ #category : #printing }
AWMetaProductionRule >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]

{ #category : #accessing }
AWMetaProductionRule >> protonotions [
	^ body protonotions
]
