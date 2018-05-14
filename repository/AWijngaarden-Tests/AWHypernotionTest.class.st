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
				withAll: {(AWProtonotion with: 'letter'). (AWMetanotion named: 'ALPHA')}) asString
		equals: 'letter ALPHA'
]

{ #category : #tests }
AWHypernotionTest >> testAsString01 [
	self
		assert:
			(AWHypernotion
				withAll: {(AWMetanotion named: 'NOTION'). (AWProtonotion with: 'list'). }) asString
		equals: 'NOTION list'
]

{ #category : #tests }
AWHypernotionTest >> testAsString02 [
	self
		assert:
			(AWHypernotion
				withAll:
					{(AWProtonotion with: 'letter').
					(AWMetanotion named: 'ALPHA').
					(AWProtonotion with: 'symbol')}) asString
		equals: 'letter ALPHA symbol'
]

{ #category : #tests }
AWHypernotionTest >> testAsString03 [
	self
		assert:
			(AWHypernotion
				withAll:
					{(AWProtonotion with: 'letter').
					(AWProtonotion with: 'a').
					(AWProtonotion with: 'symbol')}) asString
		equals: 'letter a symbol'
]

{ #category : #tests }
AWHypernotionTest >> testAsString04 [
	self assert: (AWHypernotion withAll: {}) asString equals: ''.
	self assert: AWHypernotion new asString equals: ''
]

{ #category : #tests }
AWHypernotionTest >> testIsEmpty [
	self assert: AWHypernotion new isEmpty
]
