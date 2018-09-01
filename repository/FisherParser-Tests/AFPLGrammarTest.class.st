"
test PL grammar.

"
Class {
	#name : #AFPLGrammarTest,
	#superclass : #AFGrammarTest,
	#category : #'FisherParser-Tests-Grammar'
}

{ #category : #running }
AFPLGrammarTest >> setUp [
	super setUp.
	grammar := self examples pl
]

{ #category : #tests }
AFPLGrammarTest >> testAcceptsAZ [
	self assert: (grammar accepts: 'az')
]

{ #category : #tests }
AFPLGrammarTest >> testAcceptsBJ [
	self assert: (grammar accepts: 'bj')
]
