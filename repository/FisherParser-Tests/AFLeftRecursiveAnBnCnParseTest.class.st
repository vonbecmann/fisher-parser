Class {
	#name : #AFLeftRecursiveAnBnCnParseTest,
	#superclass : #AFParseGrammarTest,
	#category : #'FisherParser-Tests-Parsing'
}

{ #category : #running }
AFLeftRecursiveAnBnCnParseTest >> setUp [
	super setUp.
	grammar := self examples leftRecursiveAnbncn.
	forest := nil
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
	| tree |
	tree := grammar parseTree: 'aabbcc'.
	self assert: tree isNotNil
]
