Class {
	#name : #JEVWEvaluatorTest,
	#superclass : #TestCase,
	#instVars : [
		'evaluator'
	],
	#category : #'EarleyVW-Tests'
}

{ #category : #asserting }
JEVWEvaluatorTest >> assertThatEvaluates: aString startingAt: aNonterminalNamed equals: expected [
	self 
		assert: (evaluator evaluate: aString startingAt: aNonterminalNamed) 
		equals: expected
]

{ #category : #initialization }
JEVWEvaluatorTest >> setUp [
	evaluator := JEVWParser vwEvaluator.
	
]

{ #category : #'tests - hypernotion' }
JEVWEvaluatorTest >> testEvaluatesHypernotion [
	self
		assertThatEvaluates: 'NOTION option'
		startingAt: 'hypernotion'
		equals:
			(AWHypernotion
				withAll: {(AWMetanotion named: 'NOTION'). (AWProtonotion with: 'option')})
]

{ #category : #'tests - hypernotion' }
JEVWEvaluatorTest >> testEvaluatesHypernotion02 [
	self
		assertThatEvaluates: 'option'
		startingAt: 'hypernotion'
		equals: (AWHypernotion with: (AWProtonotion with: 'option'))
]

{ #category : #'tests - hypernotion' }
JEVWEvaluatorTest >> testEvaluatesHypernotion03 [
	self
		assertThatEvaluates: 'NOTION'
		startingAt: 'hypernotion'
		equals: (AWHypernotion with: (AWMetanotion named: 'NOTION'))
]

{ #category : #'tests - metanotion' }
JEVWEvaluatorTest >> testEvaluatesMetanotion [
	self
		assertThatEvaluates: 'NOTION'
		startingAt: 'metanotion'
		equals: (AWMetanotion named: 'NOTION')
]

{ #category : #'tests - protonotion' }
JEVWEvaluatorTest >> testEvaluatesProtonotion [
	self
		assertThatEvaluates: 'left'
		startingAt: 'protonotion'
		equals: (AWProtonotion with: 'left')
]
