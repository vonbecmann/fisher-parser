Class {
	#name : 'JEVWEvaluatorTest',
	#superclass : 'JEVWGrammarTest',
	#instVars : [
		'evaluator'
	],
	#category : 'EarleyVW-Tests',
	#package : 'EarleyVW',
	#tag : 'Tests'
}

{ #category : 'asserting' }
JEVWEvaluatorTest >> assertGrammarAt: aGrammar evaluates: aString equals: expected [
	self
		assert: (evaluator evaluateTree: (aGrammar parseTree: aString))
		equals: expected
]

{ #category : 'asserting' }
JEVWEvaluatorTest >> assertThatEvaluates: aString equals: expected [
	self
		assert: (evaluator evaluate: aString)
		equals: expected
]

{ #category : 'running' }
JEVWEvaluatorTest >> setUp [
	super setUp.
	evaluator := JEVWParserResource current evaluator
]

{ #category : 'running' }
JEVWEvaluatorTest >> tearDown [
	evaluator := nil.
	super tearDown
]

{ #category : 'tests' }
JEVWEvaluatorTest >> testEvaluates [
	self
		assertThatEvaluates:
'ALPHA:: 		a; b; c; d; e.

s:  		ALPHA.
ALPHA: 	letter ALPHA symbol;
			ALPHA, letter ALPHA symbol.'
		equals: {
{(AWMetaProductionRule
	head: (AWMetanotion named: 'ALPHA')
	body: (AWHypernotion with: (AWProtonotion with: 'a'))).
 (AWMetaProductionRule
	head: (AWMetanotion named: 'ALPHA')
	body: (AWHypernotion with: (AWProtonotion with: 'b'))).
 (AWMetaProductionRule
	head: (AWMetanotion named: 'ALPHA')
	body: (AWHypernotion with: (AWProtonotion with: 'c'))).
 (AWMetaProductionRule
	head: (AWMetanotion named: 'ALPHA')
	body: (AWHypernotion with: (AWProtonotion with: 'd'))).
 (AWMetaProductionRule
	head: (AWMetanotion named: 'ALPHA')
	body: (AWHypernotion with: (AWProtonotion with: 'e')))}.
{
(AWHyperRule
	head: (AWHypernotion with: (AWProtonotion with: 's'))
	body: 	{(AWHypernotion with: (AWMetanotion named: 'ALPHA'))}).
(AWHyperRule
	head: (AWHypernotion with: (AWMetanotion named: 'ALPHA'))
	body:{
	(AWHypernotion
		withAll: {(AWProtonotion with: 'letter').
		(AWMetanotion named: 'ALPHA').
		(AWProtonotion with: 'symbol')})}).
(AWHyperRule
	head: (AWHypernotion with: (AWMetanotion named: 'ALPHA'))
	body:{(AWHypernotion with: (AWMetanotion named: 'ALPHA')).
			(AWHypernotion
				withAll: {(AWProtonotion with: 'letter').
							(AWMetanotion named: 'ALPHA').
							(AWProtonotion with: 'symbol')})
	})}}
]

{ #category : 'tests - hyper rule' }
JEVWEvaluatorTest >> testEvaluatesHyperRule [
	self
		assertGrammarAt: hyperRule
		evaluates: 'empty: .'
		equals: {(AWHyperRule head: (AWHypernotion with: (AWProtonotion with: 'empty')))}
]

{ #category : 'tests - hyper rule' }
JEVWEvaluatorTest >> testEvaluatesHyperRule02 [
	self
		assertGrammarAt: hyperRule
		evaluates: 'empty:.'
		equals: {(AWHyperRule head: (AWHypernotion with: (AWProtonotion with: 'empty')))}
]

{ #category : 'tests - hyper rule' }
JEVWEvaluatorTest >> testEvaluatesHyperRule03 [
	self
		assertGrammarAt: hyperRule
		evaluates: 'NOTION sequence: NOTION; NOTION, NOTION sequence.'
		equals:
			{(AWHyperRule
				head:
					(AWHypernotion
						withAll:
							{(AWMetanotion named: 'NOTION').
							(AWProtonotion with: 'sequence')})
				body: {(AWHypernotion with: (AWMetanotion named: 'NOTION'))}).
			(AWHyperRule
				head:
					(AWHypernotion
						withAll:
							{(AWMetanotion named: 'NOTION').
							(AWProtonotion with: 'sequence')})
				body:
					{(AWHypernotion with: (AWMetanotion named: 'NOTION')).
					(AWHypernotion
						withAll:
							{(AWMetanotion named: 'NOTION').
							(AWProtonotion with: 'sequence')})})}
]

{ #category : 'tests - hyper rule' }
JEVWEvaluatorTest >> testEvaluatesHyperRule04 [
	self
		assertGrammarAt: hyperRule
		evaluates: 'where <NOTION> is <NOTION>: EMPTY.'
		equals:
			{(AWHyperRule
				head:
					(AWHypernotion
						withAll:
							{(AWProtonotion with: 'where').
							(AWProtonotion with: '<').
							(AWMetanotion named: 'NOTION').
							(AWProtonotion with: '>').
							(AWProtonotion with: 'is').
							(AWProtonotion with: '<').
							(AWMetanotion named: 'NOTION').
							(AWProtonotion with: '>')})
				body: {(AWHypernotion with: (AWMetanotion named: 'EMPTY'))})}
]

{ #category : 'tests - hyper rules' }
JEVWEvaluatorTest >> testEvaluatesHyperRules [
	self
		assertGrammarAt: hyperRules
		evaluates:
'program:	 			TALLY as, TALLY bs, TALLY cs.
i TALLY LETTER s: 	i LETTER s, TALLY LETTER s.
i LETTER s: 			LETTER symbol.'
		equals:
			{(AWHyperRule
				head: (AWHypernotion with: (AWProtonotion with: 'program'))
				body:
					{(AWHypernotion
						withAll:
							{(AWMetanotion named: 'TALLY').
							(AWProtonotion with: 'as')}).
					(AWHypernotion
						withAll:
							{(AWMetanotion named: 'TALLY').
							(AWProtonotion with: 'bs')}).
					(AWHypernotion
						withAll:
							{(AWMetanotion named: 'TALLY').
							(AWProtonotion with: 'cs')})}).
			(AWHyperRule
				head:
					(AWHypernotion
						withAll:
							{(AWProtonotion with: 'i').
							(AWMetanotion named: 'TALLY').
							(AWMetanotion named: 'LETTER').
							(AWProtonotion with: 's')})
				body:
					{(AWHypernotion
						withAll:
							{(AWProtonotion with: 'i').
							(AWMetanotion named: 'LETTER').
							(AWProtonotion with: 's')}).
					(AWHypernotion
						withAll:
							{(AWMetanotion named: 'TALLY').
							(AWMetanotion named: 'LETTER').
							(AWProtonotion with: 's')})}).
			(AWHyperRule
				head:
					(AWHypernotion
						withAll:
							{(AWProtonotion with: 'i').
							(AWMetanotion named: 'LETTER').
							(AWProtonotion with: 's')})
				body:
					{(AWHypernotion
						withAll:
							{(AWMetanotion named: 'LETTER').
							(AWProtonotion with: 'symbol')})})}
]

{ #category : 'tests - hypernotion' }
JEVWEvaluatorTest >> testEvaluatesHypernotion [
	self
		assertGrammarAt: hypernotion
		evaluates: 'NOTION option'
		equals:
			(AWHypernotion
				withAll:
					{(AWMetanotion named: 'NOTION').
					(AWProtonotion with: 'option')})
]

{ #category : 'tests - hypernotion' }
JEVWEvaluatorTest >> testEvaluatesHypernotion02 [
	self
		assertGrammarAt: hypernotion
		evaluates: 'option'
		equals: (AWHypernotion with: (AWProtonotion with: 'option'))
]

{ #category : 'tests - hypernotion' }
JEVWEvaluatorTest >> testEvaluatesHypernotion03 [
	self
		assertGrammarAt: hypernotion
		evaluates: 'NOTION'
		equals: (AWHypernotion with: (AWMetanotion named: 'NOTION'))
]

{ #category : 'tests - hypernotion' }
JEVWEvaluatorTest >> testEvaluatesHypernotion04 [
	self
		assertGrammarAt: hypernotion
		evaluates: 'WHETHER (NOTETY1) is (NOTETY2)'
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

{ #category : 'tests - hypernotion' }
JEVWEvaluatorTest >> testEvaluatesHypernotion05 [
	self
		assertGrammarAt: hypernotion
		evaluates: 'where <NOTION> is <NOTION>'
		equals:
			(AWHypernotion
				withAll:
					{(AWProtonotion with: 'where').
					(AWProtonotion with: '<').
					(AWMetanotion named: 'NOTION').
					(AWProtonotion with: '>').
					(AWProtonotion with: 'is').
					(AWProtonotion with: '<').
					(AWMetanotion named: 'NOTION').
					(AWProtonotion with: '>')})
]

{ #category : 'tests - metaproduction rule' }
JEVWEvaluatorTest >> testEvaluatesMetaProductionRule [
	self
		assertGrammarAt: metaproductionRule
		evaluates: 'EMPTY:: .'
		equals: {(AWMetaProductionRule head: (AWMetanotion named: 'EMPTY'))}
]

{ #category : 'tests - metaproduction rule' }
JEVWEvaluatorTest >> testEvaluatesMetaProductionRule02 [
	self
		assertGrammarAt: metaproductionRule
		evaluates: 'LETTER:: a; b; c.'
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

{ #category : 'tests - metaproduction rule' }
JEVWEvaluatorTest >> testEvaluatesMetaProductionRule03 [
	self
		assertGrammarAt: metaproductionRule
		evaluates: 'N:: n; Nn.'
		equals:
			{(AWMetaProductionRule
				head: (AWMetanotion named: 'N')
				body: (AWHypernotion with: (AWProtonotion with: 'n'))).
			(AWMetaProductionRule
				head: (AWMetanotion named: 'N')
				body:
					(AWHypernotion
						withAll:
							{(AWMetanotion named: 'N').
							(AWProtonotion with: 'n')}))}
]

{ #category : 'tests - metaproductions' }
JEVWEvaluatorTest >> testEvaluatesMetaProductions [
	self
		assertGrammarAt: metaproductions
		evaluates:
'TALLY:: 		i TALLETY.
TALLETY:: 	TALLY; EMPTY.
EMPTY:: 		.
LETTER:: 		a; b; c.'
		equals:
			{(AWMetaProductionRule
				head: (AWMetanotion named: 'TALLY')
				body:
					(AWHypernotion
						withAll:
							{(AWProtonotion with: 'i').
							(AWMetanotion named: 'TALLETY')})).
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

{ #category : 'tests - metaproductions' }
JEVWEvaluatorTest >> testEvaluatesMetaProductions02 [
	self
		assertGrammarAt: metaproductions
		evaluates: 'TALLETY:: 	TALLY; EMPTY.'
		equals:
			{(AWMetaProductionRule
				head: (AWMetanotion named: 'TALLETY')
				body: (AWHypernotion with: (AWMetanotion named: 'TALLY'))).
			(AWMetaProductionRule
				head: (AWMetanotion named: 'TALLETY')
				body: (AWHypernotion with: (AWMetanotion named: 'EMPTY')))}
]

{ #category : 'tests - metanotion' }
JEVWEvaluatorTest >> testEvaluatesMetanotion [
	self
		assertGrammarAt: metanotion
		evaluates: 'NOTION'
		equals: (AWMetanotion named: 'NOTION')
]

{ #category : 'tests - metanotion' }
JEVWEvaluatorTest >> testEvaluatesMetanotion02 [
	self
		assertGrammarAt: metanotion
		evaluates: 'NOTION2'
		equals: (AWMetanotion named: 'NOTION2')
]

{ #category : 'tests - protonotion' }
JEVWEvaluatorTest >> testEvaluatesProtonotion [
	self
		assertGrammarAt: protonotion
		evaluates: 'left'
		equals: (AWProtonotion with: 'left')
]
