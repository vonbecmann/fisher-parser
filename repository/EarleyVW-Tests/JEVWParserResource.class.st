"
grammar and parser resources needed for testing.

"
Class {
	#name : 'JEVWParserResource',
	#superclass : 'TestResource',
	#instVars : [
		'grammar',
		'protonotion',
		'metanotion',
		'hypernotion',
		'metaproductionRule',
		'hyperRule',
		'metaproductions',
		'hyperRules',
		'evaluator'
	],
	#category : 'EarleyVW-Tests-Core',
	#package : 'EarleyVW-Tests',
	#tag : 'Core'
}

{ #category : 'accessing' }
JEVWParserResource >> evaluator [
	^ evaluator
]

{ #category : 'accessing' }
JEVWParserResource >> grammar [
	^ grammar
]

{ #category : 'accessing' }
JEVWParserResource >> hyperRule [
	^ hyperRule
]

{ #category : 'accessing' }
JEVWParserResource >> hyperRules [
	^ hyperRules
]

{ #category : 'accessing' }
JEVWParserResource >> hypernotion [
	^ hypernotion
]

{ #category : 'accessing' }
JEVWParserResource >> metanotion [
	^ metanotion
]

{ #category : 'accessing' }
JEVWParserResource >> metaproductionRule [
	^ metaproductionRule
]

{ #category : 'accessing' }
JEVWParserResource >> metaproductions [
	^ metaproductions
]

{ #category : 'accessing' }
JEVWParserResource >> protonotion [
	^ protonotion
]

{ #category : 'running' }
JEVWParserResource >> setUp [
	super setUp.
	grammar := JEVWParser vwGrammar.
	protonotion := grammar startAt: 'protonotion'.
	metanotion := grammar startAt: 'metanotion'.
	hypernotion := grammar startAt: 'hypernotion'.
	metaproductionRule := grammar startAt: 'metaproduction rule'.
	hyperRule := grammar startAt: 'hyper rule'.
	metaproductions := grammar startAt: 'metaproductions'.
	hyperRules := grammar startAt: 'hyper rules'.
	evaluator := JEVWParser vwEvaluator
]

{ #category : 'running' }
JEVWParserResource >> tearDown [
	"Does nothing. Subclasses should override this to tear down their resource"
	grammar := protonotion := metanotion := hypernotion := nil.
	metaproductionRule := hyperRule := metaproductions := hyperRules := nil.
	evaluator := nil.
	super tearDown
]
