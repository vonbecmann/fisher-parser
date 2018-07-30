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
AFAnBnCnParseTest >> testParseABC [
	forest := grammar parse: 'abc'.
	self assert: forest isAmbiguous not
]
