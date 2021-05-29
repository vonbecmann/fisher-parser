Class {
	#name : #AFTest3ParseTest,
	#superclass : #AFParseGrammarTest,
	#category : #'FisherParser-Tests-Parsing'
}

{ #category : #running }
AFTest3ParseTest >> setUp [
	super setUp.
	grammar := self examples test3
]

{ #category : #tests }
AFTest3ParseTest >> testParseHHH [
	forest := grammar parse: 'hhh'.
	self deny: forest isAmbiguous
]

{ #category : #tests }
AFTest3ParseTest >> testParseIII [
	forest := grammar parse: 'iii'.
	self deny: forest isAmbiguous
]

{ #category : #tests }
AFTest3ParseTest >> testParseJJJ [
	forest := grammar parse: 'jjj'.
	self deny: forest isAmbiguous
]
