Class {
	#name : #AFDoubleLettersCParseTest,
	#superclass : #AFParseGrammarTest,
	#category : #'FisherParser-Tests-Parsing'
}

{ #category : #running }
AFDoubleLettersCParseTest >> setUp [
	super setUp.
	grammar := self examples doubleLettersC
]

{ #category : #running }
AFDoubleLettersCParseTest >> testParseTreeAA [
	| tree derivation |
	tree := grammar parseTree: 'aa'.
	self deny: tree isNil.
	derivation := tree leftmostDerivation.
	self
		assert: (derivation collect: #first)
		equals: (grammar hyperRuleAtAll: #(1 3 3 2)).
	self
		assert: derivation first second
		equals:
			(AFSolution
				withAll:
					{(#ALPHA1 asNotion -> 'a' asNotion).
					(#ALPHA2 asNotion -> 'a' asNotion)})
]
