"
star sequence grammar
"
Class {
	#name : #AFStarSequenceGrammarTest,
	#superclass : #TestCase,
	#instVars : [
		'grammar'
	],
	#category : #'FisherParser-Tests-Grammar'
}

{ #category : #running }
AFStarSequenceGrammarTest >> setUp [
	super setUp.
	grammar := AFExemplar starSequence
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
