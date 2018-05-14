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
AWProtonotion class >> with: aString [
	^ self basicNew initializeContents: aString
]

{ #category : #initialization }
AWProtonotion >> initializeContents: aString [
	self initialize.
	contents := aString
]

{ #category : #printing }
AWProtonotion >> printOn: aStream [
	aStream nextPutAll: contents
]
