Class {
	#name : #AWProtonotionTest,
	#superclass : #TestCase,
	#category : #'AWijngaarden-Tests'
}

{ #category : #tests }
AWProtonotionTest >> testAsString [
	self 
		assert: (AWProtonotion named: 'long') asString 
		equals: 'long'
]
