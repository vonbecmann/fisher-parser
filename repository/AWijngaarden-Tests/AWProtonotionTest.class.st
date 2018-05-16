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

{ #category : #tests }
AWProtonotionTest >> testIsTerminal [
	self deny: (AWProtonotion with: 'long') isTerminal
]

{ #category : #tests }
AWProtonotionTest >> testStringAsNotion [
	self 
		assert: 'long' asNotion 
		equals: (AWProtonotion with: 'long')
]
