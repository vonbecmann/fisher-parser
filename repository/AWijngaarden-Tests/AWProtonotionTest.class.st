Class {
	#name : #AWProtonotionTest,
	#superclass : #TestCase,
	#category : #'AWijngaarden-Tests'
}

{ #category : #tests }
AWProtonotionTest >> testAsString [
	self 
		assert: (AWProtonotion with: 'long') asString 
		equals: 'long'
]

{ #category : #tests }
AWProtonotionTest >> testAsString01 [
	self 
		assert: (AWProtonotion with: 'short') asString 
		equals: 'short'
]
