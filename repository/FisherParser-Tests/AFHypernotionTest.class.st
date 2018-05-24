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
AFHypernotionTest >> testAsStrictString [
	hypernotion := AWHypernotion withAll: {'start' asNotion. 'notion' asNotion}.
	
	self 
		assert: hypernotion asStrictString 
		equals: 'startnotion'
]

{ #category : #tests }
AFHypernotionTest >> testAsStrictString02 [
	hypernotion := AWHypernotion withAll: {#THREE asNotion. 'cs' asNotion}.

	self 
		assert: hypernotion asStrictString 
		equals: 'THREEcs'
]
