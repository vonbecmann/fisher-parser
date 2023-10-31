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
	dottedHyperRule := 
		AFDottedHyperRule
			atTheBeginningOf:
				(AFHyperRule
					headWith: (AWProtonotion with: 'start')
					bodyWith: (AFHypernotion with: (AWProtonotion with: 'program'))).

	self 
		assert: dottedHyperRule asString 
		equals: 'start: ' , middleDot , 'program.'
]

{ #category : #tests }
AFDottedHyperRuleTest >> testAsString02 [
	dottedHyperRule := 
		AFDottedHyperRule
			atTheEndOf:
				(AFHyperRule
					headWith: (AWProtonotion with: 'start')
					bodyWith: (AFHypernotion with: (AWProtonotion with: 'program'))).
	self 
		assert: dottedHyperRule asString 
		equals: 'start: program' , middleDot , '.'
]

{ #category : #tests }
AFDottedHyperRuleTest >> testDisplayStringOn [

	dottedHyperRule := AFDottedHyperRule atTheEndOf: (AFHyperRule
			                    headWith: (AWProtonotion with: 'start')
			                    bodyWith: (AFHypernotion with: (AWProtonotion with: 'program'))).
	self
		assert: dottedHyperRule displayString
		equals: 'start: program' , middleDot , '.'
]

{ #category : #tests }
AFDottedHyperRuleTest >> testDisplayStringOn02 [

	dottedHyperRule := AFDottedHyperRule atTheBeginningOf: (AFHyperRule
			                    headWith: (AWProtonotion with: 'start')
			                    bodyWith:
			                    (AFHypernotion with:
				                     (AWProtonotion with: 'program'))).
	self
		assert: dottedHyperRule displayString
		equals: 'start: ' , middleDot , 'program' , '.'
]

{ #category : #tests }
AFDottedHyperRuleTest >> testEqual [
	| one another |
	one := 
		AFDottedHyperRule
			atTheBeginningOf: 
				(AFHyperRule 
					headWith: 'start' asNotion 
					bodyWith: (AFHypernotion with: 'program' asNotion)).
	another := 
		AFDottedHyperRule
			atTheBeginningOf: 
				(AFHyperRule 
					headWith: 'start' asNotion
					bodyWith: (AFHypernotion with: 'program' asNotion)).

	self deny: one == another.
	self assert: one equals: another.
	self assert: one hash equals: another hash.
	self assert: another equals: one.
	self assert: another hash equals: one hash.
	
	
]

{ #category : #tests }
AFDottedHyperRuleTest >> testEqual02 [
	| one another |
	one := 
		AFDottedHyperRule
			atTheEndOf:
				(AFHyperRule
					headWith: 'start' asNotion
					bodyWith: (AFHypernotion with: 'program' asNotion)).
	another := 
		AFDottedHyperRule
			atTheEndOf:
				(AFHyperRule
					headWith: 'start' asNotion
					bodyWith: (AFHypernotion with: 'program' asNotion)).

	self deny: one == another.
	self assert: one equals: another.
	self assert: one hash equals: another hash.
	self assert: another equals: one.
	self assert: another hash equals: one hash

	
]

{ #category : #tests }
AFDottedHyperRuleTest >> testSymbolAtDot [
	dottedHyperRule := 
		AFDottedHyperRule
			atTheBeginningOf: 
				(AFHyperRule 
					headWith: 'start' asNotion
					bodyWith: (AFHypernotion with: 'program' asNotion)).

	self 
		assert: dottedHyperRule symbolAtDot 
		equals: (AFHypernotion with: 'program' asNotion)
]

{ #category : #tests }
AFDottedHyperRuleTest >> testSymbolAtDot02 [
	dottedHyperRule := 
		(AFHyperRule
			headWith: 'start' asNotion
			bodyWith: (AFHypernotion with: 'program' asNotion)) dotAtBeginning.
			
	self 
		assert: dottedHyperRule symbolAtDot 
		equals: (AFHypernotion with: 'program' asNotion)
]
