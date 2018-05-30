"
unify a hypernotion with a protonotion.

hypernotion - to be used
grammar - the hypernotion's grammar.

"
Class {
	#name : #AFHypernotionUnification,
	#superclass : #Object,
	#instVars : [
		'hypernotion',
		'grammar'
	],
	#category : #'FisherParser-Core-MetaUnification'
}

{ #category : #'instance creation' }
AFHypernotionUnification class >> hypernotion: aHypernotion grammar: aJEGrammar [
	^ self basicNew
		initializeHypernotion: aHypernotion grammar: aJEGrammar;
		yourself
]

{ #category : #initialization }
AFHypernotionUnification >> initializeHypernotion: aHypernotion grammar: aJEGrammar [
	self initialize.
	hypernotion := aHypernotion.
	grammar := aJEGrammar
]

{ #category : #printing }
AFHypernotionUnification >> printOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPut: $(;
		print: hypernotion;
		nextPut: $)
]

{ #category : #printing }
AFHypernotionUnification >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]

{ #category : #public }
AFHypernotionUnification >> unifyWith: aProtonotion [
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
