"
unify a hypernotion with a protonotion.

hypernotion - to be used
grammar - the hypernotion's grammar.

"
Class {
	#name : #AFHypernotionMatcher,
	#superclass : #Object,
	#instVars : [
		'hypernotion',
		'grammar'
	],
	#category : #'FisherParser-Core-MetaMatching'
}

{ #category : #'instance creation' }
AFHypernotionMatcher class >> hypernotion: aHypernotion grammar: aJEGrammar [
	^ self basicNew
		initializeHypernotion: aHypernotion grammar: aJEGrammar;
		yourself
]

{ #category : #initialization }
AFHypernotionMatcher >> initializeHypernotion: aHypernotion grammar: aJEGrammar [
	self initialize.
	hypernotion := aHypernotion.
	grammar := aJEGrammar
]

{ #category : #public }
AFHypernotionMatcher >> matches: aProtonotion [
	"a hypernotion equals a protonotion, you need the relative substitution"

	| sentence |
	sentence := aProtonotion asStrictString.
	^ (grammar accepts: sentence)
		ifTrue: [ 
			AFSubstitution
				solution: ((grammar parseTree: sentence) substitutionsOf: hypernotion metanotions) ]
		ifFalse: [ "a hypernotion is not equal a protonotion" 
			AFSubstitution noSolution ]
]

{ #category : #printing }
AFHypernotionMatcher >> printOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPut: $(;
		print: hypernotion;
		nextPut: $)
]

{ #category : #printing }
AFHypernotionMatcher >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]
