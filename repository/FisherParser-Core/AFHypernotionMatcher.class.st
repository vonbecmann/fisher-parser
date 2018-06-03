"
match a hypernotion to a protonotion.

hypernotion - to be used
grammar - the hypernotion's grammar.

use jay earley parser as a pattern matching algorithm.

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
AFHypernotionMatcher >> match: aProtonotion [
	| sentence |
	sentence := aProtonotion asStrictString.
	^ (grammar accepts: sentence)
		ifTrue: [ "a hypernotion match a protonotion, you need the relative substitution"
			| metanotionSubstitutions |
			metanotionSubstitutions := (grammar parseTree: sentence) substitutionsOf: hypernotion metanotions.
			hypernotion metanotions size = metanotionSubstitutions size
				ifTrue: [ AFSubstitution solution: metanotionSubstitutions ]
				ifFalse: [ AFSubstitution noSolution ] ]
		ifFalse: [ "a hypernotion does not match a protonotion" 
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
