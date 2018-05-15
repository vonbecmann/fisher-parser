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
