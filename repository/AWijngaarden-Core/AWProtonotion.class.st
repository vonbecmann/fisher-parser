"
- A ""protonotion"" is a possible empty sequence of small syntactic marks. (e.g. *long*  and *short*)
- ""small syntactic marks"" as $a-$z, $(, $).

"
Class {
	#name : #AWProtonotion,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'AWijngaarden-Core'
}

{ #category : #'instance creation' }
AWProtonotion class >> named: aString [
	^ self basicNew initializeName: aString
]

{ #category : #initialization }
AWProtonotion >> initializeName: aString [
	self initialize.
	name := aString asSymbol
]

{ #category : #printing }
AWProtonotion >> printOn: aStream [
	aStream nextPutAll: name
]
