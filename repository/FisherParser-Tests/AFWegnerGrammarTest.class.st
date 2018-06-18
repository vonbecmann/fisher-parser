"
wegner grammar.
"
Class {
	#name : #AFWegnerGrammarTest,
	#superclass : #AFGrammarTest,
	#category : #'FisherParser-Tests-Grammar'
}

{ #category : #running }
AFWegnerGrammarTest >> setUp [
	super setUp.
	grammar := self examples wegner
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
