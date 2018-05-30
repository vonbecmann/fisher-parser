"
use jay earley parser as a syntactic unification algorithm.

"
Class {
	#name : #AFUnificationBuilder,
	#superclass : #Object,
	#instVars : [
		'metaGrammar'
	],
	#category : #'FisherParser-Core-MetaUnification'
}

{ #category : #'instance creation' }
AFUnificationBuilder class >> metaRules: metaRuleCollection orthoRepresentations: terminalNotionToRepresentationList [
	^ self basicNew
		initializeMetaGrammar:
			(AFJEMetaGrammar
				metaRules: metaRuleCollection
				orthoRepresentations: terminalNotionToRepresentationList);
		yourself
]

{ #category : #public }
AFUnificationBuilder >> buildWith: aHypernotion [
	^ aHypernotion isHypernotion
		ifTrue: [ 
			AFHypernotionUnification 
				hypernotion: aHypernotion 
				grammar: (metaGrammar startAt: aHypernotion) ]
		ifFalse: [ 
			aHypernotion isProtonotion
				ifTrue: [ AFProtonotionUnification protonotion: aHypernotion ]
				ifFalse: [ AFNoSolutionUnification new ] ]
]

{ #category : #initialization }
AFUnificationBuilder >> initializeMetaGrammar: aMetaGrammar [
	self initialize.
	metaGrammar := aMetaGrammar
]
