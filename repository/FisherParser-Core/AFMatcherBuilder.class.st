"
use jay earley parser as a syntactic unification algorithm.

"
Class {
	#name : #AFMatcherBuilder,
	#superclass : #Object,
	#instVars : [
		'metaGrammar'
	],
	#category : #'FisherParser-Core-MetaMatching'
}

{ #category : #'instance creation' }
AFMatcherBuilder class >> metaRules: metaRuleCollection orthoRepresentations: terminalNotionToRepresentationList [
	^ self basicNew
		initializeMetaGrammar:
			(AFJEMetaGrammar
				metaRules: metaRuleCollection
				orthoRepresentations: terminalNotionToRepresentationList);
		yourself
]

{ #category : #public }
AFMatcherBuilder >> createHypernotionMatcherFor: aHypernotion [
	^ AFHypernotionMatcher 
			hypernotion: aHypernotion 
			grammar: (metaGrammar startAt: aHypernotion)
]

{ #category : #public }
AFMatcherBuilder >> createProtonotionMatcherFor: aProtonotion [
	^ AFProtonotionMatcher protonotion: aProtonotion
]

{ #category : #initialization }
AFMatcherBuilder >> initializeMetaGrammar: aMetaGrammar [
	self initialize.
	metaGrammar := aMetaGrammar
]
