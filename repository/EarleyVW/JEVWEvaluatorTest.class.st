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

{ #category : #'tests - hyper rule' }
JEVWEvaluatorTest >> testEvaluatesHyperRule [
	self
		assertThatEvaluates: 'empty: .'
		startingAt: 'hyper rule'
		equals: {(AWHyperRule head: (AWHypernotion with: (AWProtonotion with: 'empty')))}
]

{ #category : #'tests - hyper rule' }
JEVWEvaluatorTest >> testEvaluatesHyperRule02 [
	self
		assertThatEvaluates: 'empty:.'
		startingAt: 'hyper rule'
		equals: {(AWHyperRule head: (AWHypernotion with: (AWProtonotion with: 'empty')))}
]

{ #category : #'tests - hyper rule' }
JEVWEvaluatorTest >> testEvaluatesHyperRule03 [
	self
		assertThatEvaluates: 'NOTION sequence: NOTION; NOTION, NOTION sequence.'
		startingAt: 'hyper rule'
		equals:
			{(AWHyperRule
				head:
					(AWHypernotion
						withAll: {(AWMetanotion named: 'NOTION'). (AWProtonotion with: 'sequence')})
				body: {(AWHypernotion with: (AWMetanotion named: 'NOTION'))}).
			(AWHyperRule
				head:
					(AWHypernotion
						withAll: {(AWMetanotion named: 'NOTION').(AWProtonotion with: 'sequence')})
				body:
					{(AWHypernotion with: (AWMetanotion named: 'NOTION')).
					(AWHypernotion
						withAll: {(AWMetanotion named: 'NOTION'). (AWProtonotion with: 'sequence')})})}
]

{ #category : #'tests - hyper rules' }
JEVWEvaluatorTest >> testEvaluatesHyperRules [
	self
		assertThatEvaluates:
'program:	 			TALLY as, TALLY bs, TALLY cs.
i TALLY LETTER s: 	i LETTER s, TALLY LETTER s.
i LETTER s: 			LETTER symbol.'	
		startingAt: 'hyper rules'
		equals: {
(AWHyperRule 
	head: (AWHypernotion with: (AWProtonotion with: 'program'))
	body: 	{(AWHypernotion withAll: {(AWMetanotion named: 'TALLY').(AWProtonotion with: 'as')}).
			(AWHypernotion withAll: {(AWMetanotion named: 'TALLY').(AWProtonotion with: 'bs')}).
			(AWHypernotion withAll: {(AWMetanotion named: 'TALLY').(AWProtonotion with: 'cs')})}).
(AWHyperRule 
	head: 
		(AWHypernotion 
			withAll: {(AWProtonotion with: 'i').(AWMetanotion named: 'TALLY').
						(AWMetanotion named: 'LETTER').(AWProtonotion with: 's')})
	body:{(AWHypernotion 
				withAll: {(AWProtonotion with: 'i').(AWMetanotion named: 'LETTER').(AWProtonotion with: 's')}).
			(AWHypernotion 
				withAll: {(AWMetanotion named: 'TALLY').(AWMetanotion named: 'LETTER').(AWProtonotion with: 's')})}).
(AWHyperRule 
	head: 
		(AWHypernotion 
			withAll: {(AWProtonotion with: 'i').(AWMetanotion named: 'LETTER').(AWProtonotion with: 's')})
	body:{(AWHypernotion withAll: {(AWMetanotion named: 'LETTER').(AWProtonotion with: 'symbol')})})}
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

{ #category : #'tests - hypernotion' }
JEVWEvaluatorTest >> testEvaluatesHypernotion04 [
	self
		assertThatEvaluates: 'WHETHER (NOTETY1) is (NOTETY2)'
		startingAt: 'hypernotion'
		equals:
			(AWHypernotion
				withAll:
					{(AWMetanotion named: 'WHETHER').
					(AWProtonotion with: '(').
					(AWMetanotion named: 'NOTETY1').
					(AWProtonotion with: ')').
					(AWProtonotion with: 'is').
					(AWProtonotion with: '(').
					(AWMetanotion named: 'NOTETY2').
					(AWProtonotion with: ')')})
]

{ #category : #'tests - metaproduction rule' }
JEVWEvaluatorTest >> testEvaluatesMetaProductionRule [
	self
		assertThatEvaluates: 'EMPTY:: .'
		startingAt: 'metaproduction rule'
		equals: {(AWMetaProductionRule head: (AWMetanotion named: 'EMPTY'))}
]

{ #category : #'tests - metaproduction rule' }
JEVWEvaluatorTest >> testEvaluatesMetaProductionRule02 [
	self
		assertThatEvaluates: 'LETTER:: a; b; c.'
		startingAt: 'metaproduction rule'
		equals:
			{(AWMetaProductionRule
				head: (AWMetanotion named: 'LETTER')
				body: (AWHypernotion with: (AWProtonotion with: 'a'))).
			(AWMetaProductionRule
				head: (AWMetanotion named: 'LETTER')
				body: (AWHypernotion with: (AWProtonotion with: 'b'))).
			(AWMetaProductionRule
				head: (AWMetanotion named: 'LETTER')
				body: (AWHypernotion with: (AWProtonotion with: 'c')))}
]

{ #category : #'tests - metaproduction rule' }
JEVWEvaluatorTest >> testEvaluatesMetaProductionRule03 [
	self
		assertThatEvaluates: 'N:: n; Nn.'
		startingAt: 'metaproduction rule'
		equals:
			{(AWMetaProductionRule
				head: (AWMetanotion named: 'N')
				body: (AWHypernotion with: (AWProtonotion with: 'n'))).
			(AWMetaProductionRule
				head: (AWMetanotion named: 'N')
				body: (AWHypernotion withAll: {(AWMetanotion named: 'N'). (AWProtonotion with: 'n')}))}
]

{ #category : #'tests - metaproductions' }
JEVWEvaluatorTest >> testEvaluatesMetaProductions [
	self
		assertThatEvaluates:
'TALLY:: 		i TALLETY.
TALLETY:: 	TALLY; EMPTY.
EMPTY:: 		.
LETTER:: 		a; b; c.'
		startingAt: 'metaproductions'
		equals:
			{(AWMetaProductionRule
				head: (AWMetanotion named: 'TALLY')
				body: (AWHypernotion withAll: {(AWProtonotion with: 'i'). (AWMetanotion named: 'TALLETY')})).
			(AWMetaProductionRule
				head: (AWMetanotion named: 'TALLETY')
				body: (AWHypernotion with: (AWMetanotion named: 'TALLY'))).
			(AWMetaProductionRule
				head: (AWMetanotion named: 'TALLETY')
				body: (AWHypernotion with: (AWMetanotion named: 'EMPTY'))).
			(AWMetaProductionRule head: (AWMetanotion named: 'EMPTY')).
			(AWMetaProductionRule
				head: (AWMetanotion named: 'LETTER')
				body: (AWHypernotion with: (AWProtonotion with: 'a'))).
			(AWMetaProductionRule
				head: (AWMetanotion named: 'LETTER')
				body: (AWHypernotion with: (AWProtonotion with: 'b'))).
			(AWMetaProductionRule
				head: (AWMetanotion named: 'LETTER')
				body: (AWHypernotion with: (AWProtonotion with: 'c')))}
]

{ #category : #'tests - metaproductions' }
JEVWEvaluatorTest >> testEvaluatesMetaProductions02 [
	self
		assertThatEvaluates: 'TALLETY:: 	TALLY; EMPTY.'
		startingAt: 'metaproductions'
		equals:
			{(AWMetaProductionRule
				head: (AWMetanotion named: 'TALLETY')
				body: (AWHypernotion with: (AWMetanotion named: 'TALLY'))).
			(AWMetaProductionRule
				head: (AWMetanotion named: 'TALLETY')
				body: (AWHypernotion with: (AWMetanotion named: 'EMPTY')))}
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
