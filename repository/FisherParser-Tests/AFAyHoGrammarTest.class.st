"
Practical Earley Parsing
John Aycock
R. Nigel Horspool
page 2, figure 2
"
Class {
	#name : #AFAyHoGrammarTest,
	#superclass : #AFGrammarTest,
	#category : #'FisherParser-Tests-Grammar'
}

{ #category : #running }
AFAyHoGrammarTest >> setUp [
	super setUp.
	grammar := AFVWGrammar
		evw: 'EMPTY::.
s: a, a, a, a.
a: e.
a: letter a symbol.
e:.'
		representations: {(#('letter' 'a' 'symbol') -> (NCTerminal character: $a))}
]

{ #category : #tests }
AFAyHoGrammarTest >> testAccepts1A [
	self assert: (grammar accepts: 'a')
]

{ #category : #tests }
AFAyHoGrammarTest >> testAccepts2A [
	self assert: (grammar accepts: 'aa')
]

{ #category : #tests }
AFAyHoGrammarTest >> testAccepts3A [
	self assert: (grammar accepts: 'aaa')
]

{ #category : #tests }
AFAyHoGrammarTest >> testAccepts4A [
	self assert: (grammar accepts: 'aaaa')
]

{ #category : #tests }
AFAyHoGrammarTest >> testAcceptsEpsilon [
	self assert: (grammar accepts: '')
]
