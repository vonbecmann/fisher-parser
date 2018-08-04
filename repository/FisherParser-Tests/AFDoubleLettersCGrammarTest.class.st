"
double letters c grammar tests.

"
Class {
	#name : #AFDoubleLettersCGrammarTest,
	#superclass : #AFGrammarTest,
	#category : #'FisherParser-Tests-Grammar'
}

{ #category : #running }
AFDoubleLettersCGrammarTest >> setUp [
	super setUp.
	grammar := self examples doubleLettersC
]

{ #category : #tests }
AFDoubleLettersCGrammarTest >> testAcceptsAA [
	self assert: (grammar accepts: 'aa')
]

{ #category : #tests }
AFDoubleLettersCGrammarTest >> testAcceptsAB [
	self deny: (grammar accepts: 'ab')
]
