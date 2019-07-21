"
three as, three bs and three cs parsing tests
"
Class {
	#name : #AFA3B3C3ParseTest,
	#superclass : #AFParseGrammarTest,
	#category : #'FisherParser-Tests-Parsing'
}

{ #category : #running }
AFA3B3C3ParseTest >> setUp [
	super setUp.
	grammar := self examples a3b3c3.
	forest := nil
]

{ #category : #tests }
AFA3B3C3ParseTest >> testParseA3B3C3 [
	forest := grammar parse: 'aaabbbccc.'.
	self assert: forest isAmbiguous
]
