"
create a matcher for a given hypernotion

"
Class {
	#name : #AFMatcherCreator,
	#superclass : #Object,
	#instVars : [
		'metaGrammar'
	],
	#category : #'FisherParser-Core-MetaMatching'
}

{ #category : #'instance creation' }
AFMatcherCreator class >> metaRules: metaRuleCollection orthoRepresentations: terminalNotionToRepresentationList [
	^ self basicNew
		initializeMetaGrammar:
			(AFJEMetaGrammar
				metaRules: metaRuleCollection
				orthoRepresentations: terminalNotionToRepresentationList);
		yourself
]

{ #category : #public }
AFMatcherCreator >> createHypernotionMatcherFor: aHypernotion [
	^ AFHypernotionMatcher 
			hypernotion: aHypernotion 
			grammar: (metaGrammar startAt: aHypernotion)
]

{ #category : #public }
AFMatcherCreator >> createProtonotionMatcherFor: aProtonotion [
	^ AFProtonotionMatcher protonotion: aProtonotion
]

{ #category : #initialization }
AFMatcherCreator >> initializeMetaGrammar: aMetaGrammar [
	self initialize.
	metaGrammar := aMetaGrammar
]