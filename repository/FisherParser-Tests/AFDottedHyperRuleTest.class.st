Class {
	#name : #AFDottedHyperRuleTest,
	#superclass : #TestCase,
	#instVars : [
		'middleDot',
		'dottedHyperRule'
	],
	#category : #'FisherParser-Tests-Implementation'
}

{ #category : #tests }
AFDottedHyperRuleTest >> setUp [
	middleDot := String with: (Character value: 183).
	dottedHyperRule := nil
]

{ #category : #tests }
AFDottedHyperRuleTest >> testAsString [
	dottedHyperRule := AFDottedHyperRule
		atTheBeginningOf: (AFHyperRule head: #('start') asNotion body: {#('program') asNotion}).

	self 
		assert: dottedHyperRule asString 
		equals: 'start: ' , middleDot , 'program.'
]

{ #category : #tests }
AFDottedHyperRuleTest >> testAsString02 [
	dottedHyperRule := AFDottedHyperRule
		atTheEndOf: (AFHyperRule head: #('start') asNotion body: {#('program') asNotion}).

	self 
		assert: dottedHyperRule asString 
		equals: 'start: ', 'program', middleDot, '.'
		
]

{ #category : #tests }
AFDottedHyperRuleTest >> testEqual [
	| one another |
	one := AFDottedHyperRule
		atTheBeginningOf: (AFHyperRule head: #('start') asNotion body: {#('program') asNotion}).
	another := AFDottedHyperRule
		atTheBeginningOf: (AFHyperRule head: #('start') asNotion body: {#('program') asNotion}).

	self deny: one == another.
	self assert: one equals: another.
	self assert: one hash equals: another hash
	
]

{ #category : #tests }
AFDottedHyperRuleTest >> testEqual02 [
	| one another |
	one := AFDottedHyperRule
		atTheEndOf: (AFHyperRule head: #('start') asNotion body: {#('program') asNotion}).
	another := AFDottedHyperRule
		atTheEndOf: (AFHyperRule head: #('start') asNotion body: {#('program') asNotion}).

	self deny: one == another.
	self assert: one equals: another.
	self assert: one hash equals: another hash
	
]
