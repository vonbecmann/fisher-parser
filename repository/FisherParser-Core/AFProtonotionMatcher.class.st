"
match a protonotion to a protonotion.
matching using the strict syntax.

protonotion to be used
"
Class {
	#name : #AFProtonotionMatcher,
	#superclass : #Object,
	#instVars : [
		'protonotion'
	],
	#category : #'FisherParser-Core-MetaMatching'
}

{ #category : #'instance creation' }
AFProtonotionMatcher class >> protonotion: aProtonotionAFHypernotion [
	^ self basicNew
		initializeProtonotion: aProtonotionAFHypernotion;
		yourself
]

{ #category : #initialization }
AFProtonotionMatcher >> initializeProtonotion: aProtonotionAFHypernotion [
	protonotion := aProtonotionAFHypernotion
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
		nextPutAll: protonotion strictSyntax;
		nextPut: $)
]

{ #category : #printing }
AFProtonotionMatcher >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]
