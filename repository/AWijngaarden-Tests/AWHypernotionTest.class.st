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
AWHypernotionTest >> testAsString05 [
	self 
		assert: (AWHypernotion with: (AWProtonotion with: 'letter')) asString 
		equals: 'letter'
]

{ #category : #tests }
AWHypernotionTest >> testIsEmpty [
	self assert: AWHypernotion new isEmpty
]

{ #category : #tests }
AWHypernotionTest >> testIsProtonotion [
	| hn |
	hn := AWHypernotion with: (AWProtonotion with: 'a').

	self assert: hn isProtonotion.
	self deny: hn isTerminal.

	
]

{ #category : #tests }
AWHypernotionTest >> testIsProtonotion02 [
	| hn |
	hn := AWHypernotion with: (AWMetanotion named: 'ALPHA').

	self deny: hn isProtonotion.
	self deny: hn isTerminal.

]

{ #category : #tests }
AWHypernotionTest >> testIsProtonotion03 [
	| hn |
	hn := AWHypernotion with: (NCTerminal character: $a).

	self deny: hn isProtonotion.
	self assert: hn isTerminal.

]

{ #category : #tests }
AWHypernotionTest >> testIsTerminal [
	| hn |
	hn := AWHypernotion new.
	self deny: hn isTerminal.
	self deny: hn isProtonotion.

]

{ #category : #tests }
AWHypernotionTest >> testIsTerminal02 [
	| hn |
	hn := AWHypernotion with: (NCTerminal character: $a).
	self assert: hn isTerminal.
	self deny: hn isProtonotion.

]

{ #category : #tests }
AWHypernotionTest >> testIsTerminal03 [
	| hn |
	hn := AWHypernotion with: (AWProtonotion with: 'a').
	self deny: hn isTerminal.
	self assert: hn isProtonotion.

]

{ #category : #tests }
AWHypernotionTest >> testIsTerminal04 [
	| hn |
	hn := AWHypernotion with: (AWMetanotion named: 'NOTION').
	self deny: hn isTerminal.
	self deny: hn isProtonotion.

]
