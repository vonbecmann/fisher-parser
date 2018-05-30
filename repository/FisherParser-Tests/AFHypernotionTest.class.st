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
