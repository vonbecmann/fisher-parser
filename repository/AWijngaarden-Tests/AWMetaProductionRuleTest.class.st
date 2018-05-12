Class {
	#name : #AWMetaProductionRuleTest,
	#superclass : #TestCase,
	#category : #'AWijngaarden-Tests'
}

{ #category : #tests }
AWMetaProductionRuleTest >> testAsString [
	self 
		assert: (AWMetaProductionRule head: (AWMetanotion named: 'EMPTY')) asString 
		equals: 'EMPTY:: .'
]
