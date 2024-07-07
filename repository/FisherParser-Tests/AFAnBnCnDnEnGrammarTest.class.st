Class {
	#name : #AFAnBnCnDnEnGrammarTest,
	#superclass : #AFGrammarTest,
	#category : #'FisherParser-Tests-Grammar'
}

{ #category : #initialization }
AFAnBnCnDnEnGrammarTest >> setUp [

	super setUp.
	grammar := self examples anbncndnen
]

{ #category : #tests }
AFAnBnCnDnEnGrammarTest >> testAcceptsABCDE [
	self assert: (grammar accepts: 'abcde')
]
