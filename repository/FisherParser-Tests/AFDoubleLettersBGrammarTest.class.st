"
double letters b grammar tests.

"
Class {
	#name : #AFDoubleLettersBGrammarTest,
	#superclass : #AFGrammarTest,
	#category : #'FisherParser-Tests-Grammar'
}

{ #category : #running }
AFDoubleLettersBGrammarTest >> setUp [
	super setUp.
	grammar := self examples doubleLettersB
]

{ #category : #tests }
AFDoubleLettersBGrammarTest >> testYY [
	self assert: (grammar accepts: 'yy')
]
