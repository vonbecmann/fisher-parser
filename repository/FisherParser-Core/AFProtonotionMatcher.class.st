"
match a protonotion to a protonotion.
matching using the strict syntax.

protonotion to be used. a hypernotion that it is a protonotion.
"
Class {
	#name : #AFProtonotionMatcher,
	#superclass : #Object,
	#instVars : [
		'protonotion'
	],
	#category : #'FisherParser-Core-Matching'
}

{ #category : #'instance creation' }
AFProtonotionMatcher class >> protonotion: aProtonotionHypernotion [
	^ self basicNew
		initializeProtonotion: aProtonotionHypernotion;
		yourself
]

{ #category : #initialization }
AFProtonotionMatcher >> initializeProtonotion: aProtonotionHypernotion [
	protonotion := aProtonotionHypernotion
]

{ #category : #public }
AFProtonotionMatcher >> match: aProtonotion [
	" a protonotion match a protonotion, therefore the substitution is empty.
	 optimize for efficiency. "

	^ protonotion strictMatch: aProtonotion
]

{ #category : #printing }
AFProtonotionMatcher >> printOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPut: $(;
		print: protonotion;
		nextPut: $)
]

{ #category : #printing }
AFProtonotionMatcher >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]
