Class {
	#name : #AFAnBnCnParseTest,
	#superclass : #AFParseGrammarTest,
	#category : #'FisherParser-Tests-Parsing'
}

{ #category : #running }
AFAnBnCnParseTest >> setUp [
	super setUp.
	grammar := self examples anbncn.
	forest := nil
]

{ #category : #tests }
AFAnBnCnParseTest >> testParseA2B2C2 [
	forest := grammar parse: 'aabbcc'.
	self assert: forest isAmbiguous
]

{ #category : #tests }
AFAnBnCnParseTest >> testParseA3B3C3 [
	forest := grammar parse: 'aaabbbccc'.
	self assert: forest isAmbiguous
]

{ #category : #tests }
AFAnBnCnParseTest >> testParseABC [
	forest := grammar parse: 'abc'.
	self assert: forest isAmbiguous not
]
