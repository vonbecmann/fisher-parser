"
an bn grammar
"
Class {
	#name : #AFAnBnGrammarTest,
	#superclass : #TestCase,
	#instVars : [
		'grammar'
	],
	#category : #'FisherParser-Tests-Grammar'
}

{ #category : #initialization }
AFAnBnGrammarTest >> setUp [
	grammar := AFExemplar anbn
]

{ #category : #initialization }
AFAnBnGrammarTest >> testAcceptsA2B2 [
	self assert: (grammar accepts: 'aabb')
]

{ #category : #initialization }
AFAnBnGrammarTest >> testAcceptsA3B3 [
	self assert: (grammar accepts: 'aaabbb')
]

{ #category : #initialization }
AFAnBnGrammarTest >> testAcceptsAB [
	self assert: (grammar accepts: 'ab')
]
