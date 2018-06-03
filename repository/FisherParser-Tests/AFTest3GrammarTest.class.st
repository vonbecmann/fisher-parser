"
test3 grammar
"
Class {
	#name : #AFTest3GrammarTest,
	#superclass : #TestCase,
	#instVars : [
		'grammar'
	],
	#category : #'FisherParser-Tests-Grammar'
}

{ #category : #initialization }
AFTest3GrammarTest >> setUp [
	grammar := AFExemplar test3
]

{ #category : #tests }
AFTest3GrammarTest >> testAcceptsHHH [
	self assert: (grammar accepts: 'hhh')
]

{ #category : #tests }
AFTest3GrammarTest >> testAcceptsIII [
	self assert: (grammar accepts: 'iii')
]

{ #category : #tests }
AFTest3GrammarTest >> testAcceptsJJJ [
	self assert: (grammar accepts: 'jjj')
]
