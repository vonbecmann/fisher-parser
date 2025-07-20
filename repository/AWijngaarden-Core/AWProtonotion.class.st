"
- A ""protonotion"" is a possible empty sequence of small syntactic marks. (e.g. *long*  and *short*)
- ""small syntactic marks"" as $a-$z, $(, $), $<, $>

"
Class {
	#name : 'AWProtonotion',
	#superclass : 'Object',
	#instVars : [
		'smallSyntacticMarks'
	],
	#category : 'AWijngaarden-Core',
	#package : 'AWijngaarden-Core'
}

{ #category : 'instance creation' }
AWProtonotion class >> new [
	^ self with: String new
]

{ #category : 'instance creation' }
AWProtonotion class >> with: aSmallSyntacticMarkString [
	^ self basicNew
		initializeSmallSyntacticMarks: aSmallSyntacticMarkString;
		yourself
]

{ #category : 'comparing' }
AWProtonotion >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].
	^ self class == anObject class and: [ smallSyntacticMarks = anObject smallSyntacticMarks ]
]

{ #category : 'comparing' }
AWProtonotion >> hash [
	^ (self class hash + smallSyntacticMarks hash) hashMultiply
]

{ #category : 'initialization' }
AWProtonotion >> initializeSmallSyntacticMarks: aSmallSyntacticMarkString [
	self initialize.
	smallSyntacticMarks := aSmallSyntacticMarkString
]

{ #category : 'testing' }
AWProtonotion >> isEmpty [
	^ smallSyntacticMarks isEmpty
]

{ #category : 'testing' }
AWProtonotion >> isMetanotion [
	^ false
]

{ #category : 'testing' }
AWProtonotion >> isProtonotion [
	^ true
]

{ #category : 'testing' }
AWProtonotion >> isTerminal [
	^ false
]

{ #category : 'accessing' }
AWProtonotion >> letters [
	"ortholetters (alphabet): letters used"

	^ Set new
		addAll: smallSyntacticMarks;
		yourself
]

{ #category : 'printing' }
AWProtonotion >> printOn: aStream [
	aStream nextPutAll: smallSyntacticMarks
]

{ #category : 'printing' }
AWProtonotion >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]

{ #category : 'accessing' }
AWProtonotion >> smallSyntacticMarks [
	^ smallSyntacticMarks
]
