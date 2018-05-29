"
wegner grammar.
"
Class {
	#name : #AFWegnerGrammarTest,
	#superclass : #TestCase,
	#instVars : [
		'grammar'
	],
	#category : #'FisherParser-Tests-Grammar'
}

{ #category : #initialization }
AFWegnerGrammarTest >> setUp [
	grammar := AFExemplar wegner
]

{ #category : #tests }
AFWegnerGrammarTest >> testAcceptsABC [
	self assert: (grammar accepts: 'abc')
]
