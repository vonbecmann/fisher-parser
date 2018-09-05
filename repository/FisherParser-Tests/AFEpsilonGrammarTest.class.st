Class {
	#name : #AFEpsilonGrammarTest,
	#superclass : #AFGrammarTest,
	#category : #'FisherParser-Tests-Grammar'
}

{ #category : #running }
AFEpsilonGrammarTest >> setUp [
	super setUp.
	grammar := AFVWGrammar
		evw: 'EMPTY::.
s: a, b, a, b.
a: e.
b: e.
e:.'
		representations: {(#('a') -> (NCTerminal character: $a))}
]

{ #category : #tests }
AFEpsilonGrammarTest >> testAccepts1A [
	self assert: (grammar accepts: 'a')
]

{ #category : #tests }
AFEpsilonGrammarTest >> testAcceptsEpsilon [
	self assert: (grammar accepts: '')
]
