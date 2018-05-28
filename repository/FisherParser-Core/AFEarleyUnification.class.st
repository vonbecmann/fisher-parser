"
use jay earley parser as a syntactic unification algorithm.

"
Class {
	#name : #AFEarleyUnification,
	#superclass : #Object,
	#instVars : [
		'metaGrammar'
	],
	#category : #'FisherParser-Core-MetaUnification'
}

{ #category : #'instance creation' }
AFEarleyUnification class >> metaRules: metaRuleCollection orthoRepresentations: terminalNotionToRepresentationList [
	^ self basicNew
		initializeMetaGrammar:
			(AFJEMetaGrammar
				metaRules: metaRuleCollection
				orthoRepresentations: terminalNotionToRepresentationList);
		yourself
]

{ #category : #initialization }
AFEarleyUnification >> initializeMetaGrammar: aMetaGrammar [
	super initialize.
	metaGrammar := aMetaGrammar
]

{ #category : #public }
AFEarleyUnification >> unify: aHypernotion with: aProtonotion [
	| hnGrammar sentence |
	hnGrammar := metaGrammar startAt: aHypernotion.
	sentence := aProtonotion asStrictString.
	^ (hnGrammar accepts: sentence)
		ifTrue: [ 
			aHypernotion isHypernotion
				ifTrue: [ 
					AFSubstitution 
						solution: ((hnGrammar parseTree: sentence) metanotionSubstitutionsOf: aHypernotion) ]
				ifFalse: [ "is a protonotion"
					AFSubstitution emptySolution ] ]
		ifFalse: [ AFSubstitution noSolution ]
]
