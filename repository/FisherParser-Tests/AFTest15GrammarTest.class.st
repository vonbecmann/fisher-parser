"
test15 grammar
"
Class {
	#name : #AFTest15GrammarTest,
	#superclass : #AFGrammarTest,
	#category : #'FisherParser-Tests-Grammar'
}

{ #category : #running }
AFTest15GrammarTest >> setUp [
	super setUp.
	grammar := self examples test15
]

{ #category : #tests }
AFTest15GrammarTest >> testAcceptsX [
	self deny: (grammar accepts: 'x')
]
