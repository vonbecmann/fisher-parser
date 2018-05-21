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

{ #category : #initialization }
AFDottedHyperRule >> initializeHyperRule: aHyperRule dotAt: index [ 
	self initialize.
	hyperRule := aHyperRule.
	dotIndex := index 
]

{ #category : #accessing }
AFDottedHyperRule >> moveDotForward [
	^ self class of: hyperRule withDotAt: dotIndex + 1
]

{ #category : #printing }
AFDottedHyperRule >> printOn: aStream [
	"head: body with dot.
	 head: ·. "

	| middleDot |
	middleDot := Character value: 183.
	hyperRule head printOn: aStream.
	aStream nextPutAll: ': '.
	hyperRule body
		withIndexDo: [ :each :index | 
			index == 1
				ifFalse: [ aStream nextPutAll: ', ' ].
			index == dotIndex
				ifTrue: [ aStream nextPut: middleDot ].
			each printOn: aStream ].
	dotIndex > hyperRule body size ifTrue: [ aStream nextPut: middleDot ].
	aStream nextPut: $.
]

{ #category : #accessing }
AFDottedHyperRule >> startAt: aColumn [
	^ AFDottedItem of: self startAt: aColumn
]

{ #category : #accessing }
AFDottedHyperRule >> symbolAtDot [
	^ hyperRule body at: dotIndex
]
