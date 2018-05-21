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
		atTheBeginningOf: (AWHyperRule head: #('start') asNotion body: {#('program') asNotion}).

	self 
		assert: dottedHyperRule asString 
		equals: 'start: ' , middleDot , 'program.'
]

{ #category : #tests }
AFDottedHyperRuleTest >> testAsString02 [
	dottedHyperRule := AFDottedHyperRule
		atTheEndOf: (AWHyperRule head: #('start') asNotion body: {#('program') asNotion}).

	self 
		assert: dottedHyperRule asString 
		equals: 'start: ', 'program', middleDot, '.'
		
]