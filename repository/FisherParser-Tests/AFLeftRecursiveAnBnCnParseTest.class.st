Class {
	#name : #AFLeftRecursiveAnBnCnParseTest,
	#superclass : #AFParseGrammarTest,
	#category : #'FisherParser-Tests-Parsing'
}

{ #category : #running }
AFLeftRecursiveAnBnCnParseTest >> setUp [
	super setUp.
	grammar := self examples leftRecursiveAnbncn
]

{ #category : #tests }
AFLeftRecursiveAnBnCnParseTest >> testParseA2B2C2 [
	forest := grammar parse: 'aabbcc'.
	self assert: forest isAmbiguous not
]

{ #category : #tests }
AFLeftRecursiveAnBnCnParseTest >> testParseA3B3C3 [
	forest := grammar parse: 'aaabbbccc'.
	self assert: forest isAmbiguous not
]

{ #category : #tests }
AFLeftRecursiveAnBnCnParseTest >> testParseTreeA2B2C2 [
	| tree derivation |
	tree := grammar parseTree: 'aabbcc'.
	self assert: tree isNotNil.
	derivation := tree leftmostDerivation.
	self assert: derivation isNotNil.
	self
		assert: (derivation collect: #first)
		equals: (grammar hyperRuleAtAll: #(1 2 3 4 3 4 2 3 5 3 5 2 3 6 3 6))
]

{ #category : #tests }
AFLeftRecursiveAnBnCnParseTest >> testParseTreeABC [
	| tree derivation |
	tree := grammar parseTree: 'abc'.
	self assert: tree isNotNil.
	derivation := tree leftmostDerivation.
	self assert: derivation isNotNil.
	self
		assert: (derivation collect: #first)
		equals: (grammar hyperRuleAtAll: #(1 3 4 3 5 3 6))
]

{ #category : #tests }
AFLeftRecursiveAnBnCnParseTest >> testTallyIsTwo [
	| tree solution |
	tree := grammar parseTree: 'aabbcc'.
	self assert: tree isNotNil.
	self assert: grammar firstHyperRule equals: tree hyperRule.
	solution := tree solution.
	self assert: solution isNotNil.
	self
		assert: (solution applyTo: #TALLY asNotion)
		equals: 'ii' asNotion
]
