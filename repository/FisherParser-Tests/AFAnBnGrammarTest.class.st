"
an bn grammar
"
Class {
	#name : #AFAnBnGrammarTest,
	#superclass : #AFGrammarTest,
	#category : #'FisherParser-Tests-Grammar'
}

{ #category : #running }
AFAnBnGrammarTest >> setUp [
	super setUp.
	grammar := self examples anbn
]

{ #category : #tests }
AFAnBnGrammarTest >> testAcceptsA2B2 [
	self assert: (grammar accepts: 'aabb')
]

{ #category : #tests }
AFAnBnGrammarTest >> testAcceptsA3B3 [
	self assert: (grammar accepts: 'aaabbb')
]

{ #category : #tests }
AFAnBnGrammarTest >> testAcceptsAB [
	self assert: (grammar accepts: 'ab')
]

{ #category : #tests }
AFAnBnGrammarTest >> testAcceptsAC [
	self deny: (grammar accepts: 'ac')
]

{ #category : #tests }
AFAnBnGrammarTest >> testAcceptsBC [
	self deny: (grammar accepts: 'bc')
]

{ #category : #tests }
AFAnBnGrammarTest >> testAcceptsEpsilon [
	self deny: (grammar accepts: '')
]
