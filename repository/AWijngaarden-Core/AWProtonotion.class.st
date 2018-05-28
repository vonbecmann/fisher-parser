"
- A ""protonotion"" is a possible empty sequence of small syntactic marks. (e.g. *long*  and *short*)
- ""small syntactic marks"" as $a-$z, $(, $).

"
Class {
	#name : #AWProtonotion,
	#superclass : #Object,
	#instVars : [
		'contents'
	],
	#category : #'AWijngaarden-Core'
}

{ #category : #'instance creation' }
AWProtonotion class >> new [
	self error: 'use with: instead'
]

{ #category : #'instance creation' }
AWProtonotion class >> with: aString [
	^ self basicNew initializeContents: aString
]

{ #category : #comparing }
AWProtonotion >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].
	^ self class == anObject class and: [ contents = anObject contents ]
]

{ #category : #accessing }
AWProtonotion >> contents [
	^ contents
]

{ #category : #enumerating }
AWProtonotion >> do: aBlock [
	contents do: aBlock
]

{ #category : #comparing }
AWProtonotion >> hash [
	^ (self class hash + contents hash) hashMultiply
]

{ #category : #initialization }
AWProtonotion >> initializeContents: aString [
	self initialize.
	contents := aString
]

{ #category : #testing }
AWProtonotion >> isMetanotion [
	^ false
]

{ #category : #testing }
AWProtonotion >> isProtonotion [
	^ true
]

{ #category : #testing }
AWProtonotion >> isTerminal [
	^ false
]

{ #category : #printing }
AWProtonotion >> printOn: aStream [
	aStream nextPutAll: contents
]

{ #category : #printing }
AWProtonotion >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]
