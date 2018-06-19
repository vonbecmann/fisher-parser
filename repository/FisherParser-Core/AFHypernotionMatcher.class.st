"
match a hypernotion to a protonotion.

hypernotion - to be used
grammar - the hypernotion's grammar.

use jay earley parser as a pattern matching algorithm.
the hypernotion system is uniquely assignable (u.a.) [wegner]


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
AFHypernotionMatcher class >> hypernotion: anAFHypernotion grammar: aJEGrammar [
	^ self basicNew
		initializeHypernotion: anAFHypernotion grammar: aJEGrammar;
		yourself
]

{ #category : #initialization }
AFHypernotionMatcher >> initializeHypernotion: anAFHypernotion grammar: aJEGrammar [
	hypernotion := anAFHypernotion.
	grammar := aJEGrammar
]

{ #category : #public }
AFHypernotionMatcher >> match: aProtonotion [
	"	a hypernotion match a protonotion, you need the relative substitution. "

	^ [ (grammar parseTree: aProtonotion strictSyntax) substitutionsOf: hypernotion ]
		on: JEFailure
		do: [ AFSubstitution noSolution ]
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
