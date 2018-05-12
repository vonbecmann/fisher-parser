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
	^ self basicNew initializeHead: aMetanotion body: nil
]

{ #category : #initialization }
AWMetaProductionRule >> initializeHead: aMetanotion body: aHypernotion [
	self initialize.
	head := aMetanotion.
	body := aHypernotion
]

{ #category : #printing }
AWMetaProductionRule >> printOn: aStream [
	aStream
		print: head;
		nextPutAll: ':: '.
	body ifNotNil: [ aStream print: body ].
	aStream nextPut: $.
]
