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

{ #category : #tests }
AFWegnerGrammarTest >> testAnalizeAcceptsABC [
	| analysis chart |
	analysis := grammar analizeAccepts: 'abc'.

	self assert: (analysis at: 'accepts').
	chart := analysis at: 'chart'.
	self assert: chart size equals: 4.
	self assert: chart columnSizes equals: #(6 10 7 4)
]
