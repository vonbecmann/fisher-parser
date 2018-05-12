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

{ #category : #tests }
AWMetaProductionRuleTest >> testAsString01 [
	self
		assert:
			(AWMetaProductionRule
				head: (AWMetanotion named: 'SIZE')
				body: (AWHypernotion withAll: {(AWProtonotion named: 'long')})) asString
		equals: 'SIZE:: long.'
]

{ #category : #tests }
AWMetaProductionRuleTest >> testAsString02 [
	self
		assert:
			(AWMetaProductionRule
				head: (AWMetanotion named: 'SIZE')
				body: (AWHypernotion withAll: 
							{(AWProtonotion named: 'long'). (AWMetanotion named: 'SIZE')})) asString
		equals: 'SIZE:: long SIZE.'
]

{ #category : #tests }
AWMetaProductionRuleTest >> testAsString03 [
	self
		assert:
			(AWMetaProductionRule
				head: (AWMetanotion named: 'N')
				body: (AWHypernotion withAll: 
							{(AWProtonotion named: 'n'). (AWMetanotion named: 'N')})) asString
		equals: 'N:: n N.'
]
