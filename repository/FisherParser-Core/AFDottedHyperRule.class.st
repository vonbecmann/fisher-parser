"
dotted hyper rule
"
Class {
	#name : #AFDottedHyperRule,
	#superclass : #Object,
	#instVars : [
		'hyperRule',
		'dotIndex'
	],
	#category : #'FisherParser-Core-Implementation'
}

{ #category : #'instance creation' }
AFDottedHyperRule class >> atTheBeginningOf: aHyperRule [
	^ self of: aHyperRule withDotAt: 1
]

{ #category : #'instance creation' }
AFDottedHyperRule class >> atTheEndOf: aHyperRule [
	^ self of: aHyperRule withDotAt: aHyperRule body size + 1
]

{ #category : #'instance creation' }
AFDottedHyperRule class >> of: aHyperRule withDotAt: index [
	^ self basicNew
		initializeHyperRule: aHyperRule dotAt: index;
		yourself
]

{ #category : #comparing }
AFDottedHyperRule >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].
	self class == anObject class
		ifFalse: [ ^ false ].
	^ dotIndex == anObject dotIndex and: [ hyperRule = anObject hyperRule ]
]

{ #category : #accessing }
AFDottedHyperRule >> dotIndex [
	^ dotIndex
]

{ #category : #comparing }
AFDottedHyperRule >> hash [
	^ (hyperRule hash + dotIndex hash) hashMultiply
]

{ #category : #accessing }
AFDottedHyperRule >> head [
	^ hyperRule head
]

{ #category : #accessing }
AFDottedHyperRule >> hyperRule [
	^ hyperRule
]

{ #category : #initialization }
AFDottedHyperRule >> initializeHyperRule: aHyperRule dotAt: index [ 
	self initialize.
	hyperRule := aHyperRule.
	dotIndex := index 
]

{ #category : #testing }
AFDottedHyperRule >> isFinal [
	^ dotIndex > hyperRule body size
]

{ #category : #accessing }
AFDottedHyperRule >> moveDotForward [
	^ self class of: hyperRule withDotAt: dotIndex + 1
]

{ #category : #accessing }
AFDottedHyperRule >> moveDotForwardAfterApplying: aSubstitution [
	^ self class of: (hyperRule apply: aSubstitution) withDotAt: dotIndex + 1
]

{ #category : #printing }
AFDottedHyperRule >> printOn: aStream [
	"head: body with dot.
	 head: ·. "

	hyperRule head printOn: aStream.
	aStream nextPutAll: ': '.
	hyperRule body printOn: aStream withDotAt: dotIndex.
	aStream nextPut: $.
]

{ #category : #printing }
AFDottedHyperRule >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]

{ #category : #'initialize-release' }
AFDottedHyperRule >> release [
	hyperRule := dotIndex := nil.
	super release
]

{ #category : #accessing }
AFDottedHyperRule >> startAt: aColumn [
	^ AFDottedItem of: self startAt: aColumn
]

{ #category : #accessing }
AFDottedHyperRule >> startAt: firstColumn endAt: secondColumn [
	^ AFDottedItem of: self startAt: firstColumn endAt: secondColumn
]

{ #category : #accessing }
AFDottedHyperRule >> symbolAtDot [
	^ hyperRule body at: dotIndex
]
