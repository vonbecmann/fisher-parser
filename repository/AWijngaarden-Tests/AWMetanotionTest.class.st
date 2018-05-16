Class {
	#name : #AWMetanotionTest,
	#superclass : #TestCase,
	#category : #'AWijngaarden-Tests'
}

{ #category : #tests }
AWMetanotionTest >> testAsString [
	self 
		assert: (AWMetanotion named: 'TALLY') asString 
		equals: 'TALLY'
]

{ #category : #tests }
AWMetanotionTest >> testIsTerminal [
	self deny: (AWMetanotion named: 'TALLY') isTerminal
]

{ #category : #tests }
AWMetanotionTest >> testSymbolAsNotion [
	self 
		assert: #'TALLY' asNotion
		equals: (AWMetanotion named: 'TALLY')
]

{ #category : #tests }
AWMetanotionTest >> testSymbolAsNotion02 [
	self 
		assert: #TALLY asNotion
		equals: (AWMetanotion named: 'TALLY')
]
