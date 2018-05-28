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
				ifTrue: [ "a hypernotion equals a protonotion, you need the relative substitution"
					AFSubstitution 
						solution: ((hnGrammar parseTree: sentence) metanotionSubstitutionsOf: aHypernotion) ]
				ifFalse: [ "a protonotion equals a protonotion"
					AFSubstitution emptySolution ] ]
		ifFalse: [ "a hypernotion is not equal a protonotion"
			 AFSubstitution noSolution ]
]
