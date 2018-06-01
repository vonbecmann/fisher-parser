"
test15 grammar
"
Class {
	#name : #AFTest15GrammarTest,
	#superclass : #TestCase,
	#instVars : [
		'grammar'
	],
	#category : #'FisherParser-Tests-Grammar'
}

{ #category : #initialization }
AFTest15GrammarTest >> setUp [
	grammar := AFExemplar test15
]

{ #category : #initialization }
AFTest15GrammarTest >> testAcceptsX [
	self deny: (grammar accepts: 'x')
]
