Class {
	#name : #AFHypernotionTest,
	#superclass : #TestCase,
	#instVars : [
		'hypernotion'
	],
	#category : #'FisherParser-Tests-Implementation'
}

{ #category : #initialization }
AFHypernotionTest >> setUp [
	hypernotion := nil
]

{ #category : #tests }
AFHypernotionTest >> testApply [
	| hn substitution |
	hn := AFHypernotion with: (AWMetanotion named: 'X').
	substitution := AFSubstitution
		solution: {((AWMetanotion named: 'X') -> (AWProtonotion with: 'substitute'))}.

	self 
		assert: (hn apply: substitution) 
		equals: (AFHypernotion with: (AWProtonotion with: 'substitute'))
]

{ #category : #tests }
AFHypernotionTest >> testApply02 [
	| hn substitution |
	hn := AFHypernotion with: (AWMetanotion named: 'Y').
	substitution := AFSubstitution
		solution: {((AWMetanotion named: 'X') -> (AWProtonotion with: 'substitute'))}.

	self 
		assert: (hn apply: substitution) 
		equals: hn
]

{ #category : #tests }
AFHypernotionTest >> testAsStrictString [
	hypernotion := AFHypernotion withAll: {'start' asNotion. 'notion' asNotion}.
	
	self 
		assert: hypernotion asStrictString 
		equals: 'startnotion'
]

{ #category : #tests }
AFHypernotionTest >> testAsStrictString02 [
	hypernotion := AFHypernotion withAll: {#THREE asNotion. 'cs' asNotion}.

	self 
		assert: hypernotion asStrictString 
		equals: 'THREEcs'
]

{ #category : #tests }
AFHypernotionTest >> testAsString [
	self
		assert:
			(AFHypernotion
				withAll: {(AWProtonotion with: 'letter'). (AWMetanotion named: 'ALPHA')}) asString
		equals: 'letter ALPHA'
]

{ #category : #tests }
AFHypernotionTest >> testAsString02 [
	self assert: (AFHypernotion withAll: {}) asString equals: ''.
	self assert: AFHypernotion new asString equals: ''.
	self assert: AFHypernotion empty asString equals: ''
]

{ #category : #tests }
AFHypernotionTest >> testIsEmpty [
	self assert: AFHypernotion new isEmpty
]

{ #category : #tests }
AFHypernotionTest >> testIsHypernotion [
	| hn |
	hn := AFHypernotion new.
	self assert: hn isHypernotion.
	self deny: hn isTerminal.
	self deny: hn isProtonotion
]

{ #category : #tests }
AFHypernotionTest >> testIsHypernotion02 [
	| hn |
	hn := AFHypernotion with: (AWProtonotion with: 'a').
	self deny: hn isHypernotion.
	self assert: hn isProtonotion.
	self deny: hn isTerminal
]

{ #category : #tests }
AFHypernotionTest >> testIsProtonotion [
	| hn |
	hn := AFHypernotion with: (AWProtonotion with: 'a').
	self assert: hn isProtonotion.
	self deny: hn isTerminal.
	self deny: hn isHypernotion
]

{ #category : #tests }
AFHypernotionTest >> testIsProtonotion02 [
	| hn |
	hn := AFHypernotion with: (AWMetanotion named: 'ALPHA').
	self deny: hn isProtonotion.
	self deny: hn isTerminal.
	self assert: hn isHypernotion
]

{ #category : #tests }
AFHypernotionTest >> testIsProtonotion03 [
	| hn |
	hn := AFHypernotion with: (NCTerminal character: $a).

	self deny: hn isProtonotion.
	self assert: hn isTerminal.
	self deny: hn isHypernotion.
]

{ #category : #tests }
AFHypernotionTest >> testIsTerminal [
	| hn |
	hn := AFHypernotion new.
	self deny: hn isTerminal.
	self deny: hn isProtonotion.
	self assert: hn isHypernotion
]

{ #category : #tests }
AFHypernotionTest >> testIsTerminal02 [
	| hn |
	hn := AFHypernotion with: (NCTerminal character: $a).
	self assert: hn isTerminal.
	self deny: hn isProtonotion.
	self deny: hn isHypernotion
]

{ #category : #tests }
AFHypernotionTest >> testIsTerminal03 [
	| hn |
	hn := AFHypernotion with: (AWProtonotion with: 'a').
	self deny: hn isTerminal.
	self assert: hn isProtonotion.
	self deny: hn isHypernotion
]

{ #category : #tests }
AFHypernotionTest >> testIsTerminal04 [
	| hn |
	hn := AFHypernotion with: (AWMetanotion named: 'NOTION').
	self deny: hn isTerminal.
	self deny: hn isProtonotion.
	self assert: hn isHypernotion
]

{ #category : #tests }
AFHypernotionTest >> testMetanotions [
	| hn |
	hn := AFHypernotion
		withAll:
			{(AWMetanotion named: 'TALLY').
			(AWMetanotion named: 'LETTER').
			(AWProtonotion with: 's')}.
	self
		assertCollection: hn metanotions
		hasSameElements:
			{(AWMetanotion named: 'TALLY').
			(AWMetanotion named: 'LETTER')}
]

{ #category : #tests }
AFHypernotionTest >> testMetanotions02 [
	| hn |
	hn := AFHypernotion
		withAll:
			{(AWMetanotion named: 'TALLY').
			(AWMetanotion named: 'LETTER').
			(AWMetanotion named: 'LETTER').
			(AWProtonotion with: 's')}.
	self
		assertCollection: hn metanotions
		hasSameElements:
			{(AWMetanotion named: 'TALLY').
			(AWMetanotion named: 'LETTER')}
]
