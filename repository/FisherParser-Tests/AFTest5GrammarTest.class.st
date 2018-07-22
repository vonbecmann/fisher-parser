"
test5 grammar tests.
"
Class {
	#name : #AFTest5GrammarTest,
	#superclass : #AFGrammarTest,
	#category : #'FisherParser-Tests-Grammar'
}

{ #category : #running }
AFTest5GrammarTest >> setUp [
	super setUp.
	grammar := self examples test5
]

{ #category : #tests }
AFTest5GrammarTest >> testAcceptsPackOfabc [
	self assert: (grammar accepts: '(*)')
]

{ #category : #tests }
AFTest5GrammarTest >> testAcceptsStar [
	self assert: (grammar accepts: '*')
]
