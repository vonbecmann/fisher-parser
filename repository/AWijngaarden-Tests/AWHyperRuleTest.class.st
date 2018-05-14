Class {
	#name : #AWHyperRuleTest,
	#superclass : #TestCase,
	#category : #'AWijngaarden-Tests'
}

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
