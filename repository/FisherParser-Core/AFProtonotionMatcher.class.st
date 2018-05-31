"
unify a protonotion with a protonotion.

protonotion to be used
"
Class {
	#name : #AFProtonotionMatcher,
	#superclass : #Object,
	#instVars : [
		'strictProtonotion'
	],
	#category : #'FisherParser-Core-MetaMatching'
}

{ #category : #'instance creation' }
AFProtonotionMatcher class >> protonotion: aProtonotion [
	^ self basicNew
		initializeStrictProtonotion: aProtonotion;
		yourself
]

{ #category : #initialization }
AFProtonotionMatcher >> initializeStrictProtonotion: aProtonotion [
	self initialize.
	strictProtonotion := aProtonotion asStrictString
]

{ #category : #public }
AFProtonotionMatcher >> match: aProtonotion [
	"a protonotion equals a protonotion, therefore the substitution is empty"

	| sentence |
	sentence := aProtonotion asStrictString.
	strictProtonotion size == sentence size
		ifFalse: [ ^ AFSubstitution noSolution ].
	strictProtonotion
		with: sentence
		do: [ :first :second | 
			first = second
				ifFalse: [ ^ AFSubstitution noSolution ] ].
	^ AFSubstitution emptySolution
]

{ #category : #printing }
AFProtonotionMatcher >> printOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPut: $(;
		nextPutAll: strictProtonotion;
		nextPut: $)
]

{ #category : #printing }
AFProtonotionMatcher >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]
