Class {
	#name : #AWHyperRuleTest,
	#superclass : #TestCase,
	#category : #'AWijngaarden-Tests'
}

{ #category : #tests }
AWHyperRuleTest >> testAsString [
	| hyperrule |
	hyperrule := AWHyperRule head: (AWHypernotion with: (AWMetanotion named: 'EMPTY')).
	self 
		assert: hyperrule asString 
		equals: 'EMPTY: .'
]

{ #category : #tests }
AWHyperRuleTest >> testAsString02 [
	| hyperrule |
	hyperrule := AWHyperRule
		head:
			(AWHypernotion
				withAll: {(AWMetanotion named: 'NOTION'). (AWProtonotion with: 'option')})
		body: {(AWHypernotion with: (AWMetanotion named: 'NOTION'))}.
	self 
		assert: hyperrule asString 
		equals: 'NOTION option: NOTION.'
]

{ #category : #tests }
AWHyperRuleTest >> testIsRepresentation [
	| hyperrule |
	hyperrule := AWHyperRule head: (AWHypernotion with: (AWProtonotion with: 'letter')) body: {(AWHypernotion with: (NCTerminal character: $a))}.
	self assert: hyperrule isRepresentation
]

{ #category : #tests }
AWHyperRuleTest >> testIsRepresentation02 [
	| hyperrule |
	hyperrule := AWHyperRule head: (AWHypernotion with: (AWProtonotion with: 'letter')) body: {(AWHypernotion with: (AWProtonotion with: 'a'))}.
	self deny: hyperrule isRepresentation
]

{ #category : #tests }
AWHyperRuleTest >> testIsRepresentation03 [
	| hyperrule |
	hyperrule := AWHyperRule
		head:
			(AWHypernotion
				withAll: {(AWMetanotion named: 'NOTION'). (AWProtonotion with: 'option')})
		body: {(AWHypernotion with: (AWMetanotion named: 'NOTION'))}.
	self deny: hyperrule isRepresentation
]

{ #category : #tests }
AWHyperRuleTest >> testIsRepresentation04 [
	| hyperrule |
	hyperrule := AWHyperRule
		head: 	(AWHypernotion withAll: {(AWMetanotion named: 'NOTION'). (AWProtonotion with: 'option')})
		body: {}.
	self deny: hyperrule isRepresentation
]

{ #category : #tests }
AWHyperRuleTest >> testIsRepresentation05 [
	| hyperrule |
	hyperrule := AWHyperRule
		head: (AWHypernotion with: (AWMetanotion named: #LETTER))
		body: {(AWHypernotion with: (NCTerminal character: $a))}.
	self deny: hyperrule isRepresentation
]
