Class {
	#name : #AWHypernotionTest,
	#superclass : #TestCase,
	#category : #'AWijngaarden-Tests'
}

{ #category : #tests }
AWHypernotionTest >> testAsString [
	self
		assert:
			(AWHypernotion
				withAll: {(AWProtonotion named: 'letter'). (AWMetanotion named: 'ALPHA')}) asString
		equals: 'letter ALPHA'
]

{ #category : #tests }
AWHypernotionTest >> testAsString01 [
	self
		assert:
			(AWHypernotion
				withAll: {(AWMetanotion named: 'NOTION'). (AWProtonotion named: 'list'). }) asString
		equals: 'NOTION list'
]

{ #category : #tests }
AWHypernotionTest >> testAsString02 [
	self
		assert:
			(AWHypernotion
				withAll:
					{(AWProtonotion named: 'letter').
					(AWMetanotion named: 'ALPHA').
					(AWProtonotion named: 'symbol')}) asString
		equals: 'letter ALPHA symbol'
]
