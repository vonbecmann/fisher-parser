"
match a protonotion to a protonotion.

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
AFProtonotionMatcher class >> protonotion: aProtonotion [
	^ self basicNew
		initializeProtonotion: aProtonotion;
		yourself
]

{ #category : #initialization }
AFProtonotionMatcher >> initializeProtonotion: aProtonotion [
	self initialize.
	protonotion := aProtonotion
]

{ #category : #public }
AFProtonotionMatcher >> match: aProtonotion [
	" a protonotion match a protonotion, therefore the substitution is empty.
	 optimize for efficiency. "

	protonotion strictSyntax size = aProtonotion strictSyntax size
		ifFalse: [ ^ AFSubstitution noSolution ].
	1 to: protonotion strictSyntax size do: [ :index | 
		(protonotion strictSyntax at: index) = (aProtonotion strictSyntax at: index)
			ifFalse: [ ^ AFSubstitution noSolution ] ].
	^ AFSubstitution emptySolution
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
