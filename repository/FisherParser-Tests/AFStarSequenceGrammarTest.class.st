"
star sequence grammar
"
Class {
	#name : #AFStarSequenceGrammarTest,
	#superclass : #AFGrammarTest,
	#category : #'FisherParser-Tests-Grammar'
}

{ #category : #running }
AFStarSequenceGrammarTest >> setUp [
	super setUp.
	grammar := self examples starSequence
]

{ #category : #tests }
AFStarSequenceGrammarTest >> testAcceptsStar [
	self assert: (grammar accepts: '*')
]

{ #category : #tests }
AFStarSequenceGrammarTest >> testAcceptsStar2 [
	self assert: (grammar accepts: '**')
]

{ #category : #tests }
AFStarSequenceGrammarTest >> testAcceptsStar3 [
	self assert: (grammar accepts: '***')
]
