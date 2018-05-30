"
unify a protonotion with a protonotion.

protonotion to be used
"
Class {
	#name : #AFProtonotionUnification,
	#superclass : #Object,
	#instVars : [
		'strictProtonotion'
	],
	#category : #'FisherParser-Core-MetaUnification'
}

{ #category : #'instance creation' }
AFProtonotionUnification class >> protonotion: aProtonotion [
	^ self basicNew
		initializeStrictProtonotion: aProtonotion;
		yourself
]

{ #category : #initialization }
AFProtonotionUnification >> initializeStrictProtonotion: aProtonotion [
	self initialize.
	strictProtonotion := aProtonotion asStrictString
]

{ #category : #public }
AFProtonotionUnification >> unifyWith: aHypernotion [
	"a protonotion equals a protonotion, therefore the substitution is empty"

	| sentence |
	sentence := aHypernotion asStrictString.
	strictProtonotion size == sentence size
		ifFalse: [ ^ AFSubstitution noSolution ].
	strictProtonotion
		with: sentence
		do: [ :first :second | 
			first = second
				ifFalse: [ ^ AFSubstitution noSolution ] ].
	^ AFSubstitution emptySolution
]
