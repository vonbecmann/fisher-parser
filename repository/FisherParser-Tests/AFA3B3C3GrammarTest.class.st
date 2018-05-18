Class {
	#name : #AFA3B3C3GrammarTest,
	#superclass : #TestCase,
	#instVars : [
		'grammar'
	],
	#category : #'FisherParser-Tests-Grammar'
}

{ #category : #running }
AFA3B3C3GrammarTest >> setUp [
	grammar := AFExemplar a3b3c3
]

{ #category : #tests }
AFA3B3C3GrammarTest >> testAcceptsA3B3C3 [
	self assert: (grammar accepts: 'aaabbbccc.')
]
