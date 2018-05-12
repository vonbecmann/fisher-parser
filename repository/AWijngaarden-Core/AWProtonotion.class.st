"
- A ""protonotion"" is a possible empty sequence of small syntactic marks. (e.g. *long*  and *short*)
- ""small syntactic marks"" as $a-$z, $(, $).

"
Class {
	#name : #AWProtonotion,
	#superclass : #Object,
	#instVars : [
		'content'
	],
	#category : #'AWijngaarden-Core'
}

{ #category : #'instance creation' }
AWProtonotion class >> with: aString [
	^ self basicNew initializeContent: aString
]

{ #category : #initialization }
AWProtonotion >> initializeContent: aString [
	self initialize.
	content := aString
]

{ #category : #printing }
AWProtonotion >> printOn: aStream [
	aStream nextPutAll: content
]
