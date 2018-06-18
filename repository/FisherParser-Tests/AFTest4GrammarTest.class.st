"
test4 grammar tests.

"
Class {
	#name : #AFTest4GrammarTest,
	#superclass : #TestCase,
	#instVars : [
		'grammar'
	],
	#category : #'FisherParser-Tests-Grammar'
}

{ #category : #running }
AFTest4GrammarTest >> setUp [
	super setUp.
	grammar := AFExemplar test4
]

{ #category : #tests }
AFTest4GrammarTest >> testAcceptsHHH [
	self assert: (grammar accepts: 'hhh')
]

{ #category : #tests }
AFTest4GrammarTest >> testAcceptsIII [
	self assert: (grammar accepts: 'iii')
]

{ #category : #tests }
AFTest4GrammarTest >> testAcceptsJJJ [
	self assert: (grammar accepts: 'jjj')
]
