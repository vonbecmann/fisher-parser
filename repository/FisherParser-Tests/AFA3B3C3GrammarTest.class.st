"
a3 b3 c3 grammar.

"
Class {
	#name : #AFA3B3C3GrammarTest,
	#superclass : #TestCase,
	#instVars : [
		'grammar'
	],
	#category : #'FisherParser-Tests-Grammar'
}

{ #category : #running }
AFA3B3C3GrammarTest >> setUp [
	grammar := AFExemplar a3b3c3
]

{ #category : #tests }
AFA3B3C3GrammarTest >> testAcceptsA3B3C3 [
	self assert: (grammar accepts: 'aaabbbccc.')
]

{ #category : #tests }
AFA3B3C3GrammarTest >> testAnalizeAcceptsA3B3C3 [
	| analysis chart |
	analysis := grammar analizeAccepts: 'aaabbbccc.'.
	self assert: (analysis at: 'accepts').
	chart := analysis at: 'chart'.
	self assert: chart size equals: 11.
	self assert: chart columnSizes equals: #(6 6 7 10 8 8 10 8 8 7 3)
]
