Class {
	#name : #AFHypernotionTest,
	#superclass : #TestCase,
	#category : #'FisherParser-Tests-Implementation'
}

{ #category : #tests }
AFHypernotionTest >> testAsStrictString [
	| hypernotion |
	hypernotion := AWHypernotion
		withAll:
			{(AWProtonotion with: 'start').
			(AWProtonotion with: 'notion')}.
	self 
		assert: hypernotion asStrictString 
		equals: 'startnotion'
]

{ #category : #tests }
AFHypernotionTest >> testAsStrictString02 [
	| hypernotion |
	hypernotion := AWHypernotion
		withAll:
			{(AWMetanotion named: 'THREE').
			(AWProtonotion with: 'cs')}.
	self assert: hypernotion asStrictString equals: 'THREEcs'
]
