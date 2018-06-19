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
		solutionWith: (AWMetanotion named: 'X') -> (AWProtonotion with: 'substitute').

	self
		assert: (hn apply: substitution)
		equals: (AFHypernotion with: (AWProtonotion with: 'substitute'))
]

{ #category : #tests }
AFHypernotionTest >> testApply02 [
	| hn substitution |
	hn := AFHypernotion with: (AWMetanotion named: 'Y').
	substitution := AFSubstitution
		solutionWith: (AWMetanotion named: 'X') -> (AWProtonotion with: 'substitute').

	self 
		assert: (hn apply: substitution) 
		equals: hn
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
		assert: hn metanotions size 
		equals: 2.
	self
		assertCollection: hn metanotions
		hasSameElements:
			{(AWMetanotion named: 'TALLY').
			(AWMetanotion named: 'LETTER')}
]

{ #category : #tests }
AFHypernotionTest >> testOccurrencesOfMetanotion [
	| hn |
	hn := AFHypernotion
		withAll:
			{(AWMetanotion named: 'TALLY').
			(AWMetanotion named: 'LETTER').
			(AWMetanotion named: 'LETTER').
			(AWProtonotion with: 's')}.
	self 
		assert: (hn occurrencesOf: (AWMetanotion named: 'LETTER')) 
		equals: 2
]

{ #category : #tests }
AFHypernotionTest >> testOccurrencesOfProtonotion [
	| hn |
	hn := AFHypernotion
		withAll:
			{(AWProtonotion with: 'letter').
			(AWProtonotion with: 'letter').
			(AWProtonotion with: 'a').
			(AWProtonotion with: 'symbol')}.
	self 
		assert: (hn occurrencesOf: (AWProtonotion with: 'letter')) 
		equals: 2
]

{ #category : #tests }
AFHypernotionTest >> testProtonotions [
	| hn |
	hn := AFHypernotion
		withAll:
			{(AWProtonotion with: 'letter').
			(AWProtonotion with: 'a').
			(AWProtonotion with: 'symbol')}.
	self
		assertCollection: hn protonotions 
		hasSameElements:
			{(AWProtonotion with: 'letter').
			(AWProtonotion with: 'a').
			(AWProtonotion with: 'symbol')}
]

{ #category : #tests }
AFHypernotionTest >> testProtonotions02 [
	| hn |
	hn := AFHypernotion
		withAll:
			{(AWProtonotion with: 'letter').
			(AWProtonotion with: 'letter').
			(AWProtonotion with: 'a').
			(AWProtonotion with: 'symbol')}.
	self 
		assert: hn protonotions size 
		equals: 3.
	self
		assertCollection: hn protonotions 
		hasSameElements:
			{(AWProtonotion with: 'letter').
			(AWProtonotion with: 'a').
			(AWProtonotion with: 'symbol')}
]

{ #category : #tests }
AFHypernotionTest >> testProtonotions03 [
	| hn |
	hn := AFHypernotion
		withAll:
			{(AWMetanotion named: 'LETTER').
			(AWProtonotion with: 'symbol')}.
	self 
		assert: hn protonotions size 
		equals: 1.
	self
		assertCollection: hn protonotions 
		hasSameElements: {(AWProtonotion with: 'symbol')}
]

{ #category : #tests }
AFHypernotionTest >> testStrictSyntax [
	hypernotion := AFHypernotion withAll: #('start' 'notion') asNotions.
	
	self 
		assert: hypernotion strictSyntax
		equals: 'startnotion'
]

{ #category : #tests }
AFHypernotionTest >> testStrictSyntax02 [
	hypernotion := AFHypernotion withAll: #(#THREE 'cs') asNotions.

	self 
		assert: hypernotion strictSyntax 
		equals: 'THREEcs'
]
