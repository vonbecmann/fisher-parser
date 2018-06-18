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

{ #category : #running }
AFTest15GrammarTest >> setUp [
	super setUp.
	grammar := AFExemplar test15
]

{ #category : #tests }
AFTest15GrammarTest >> testAcceptsX [
	self deny: (grammar accepts: 'x')
]
