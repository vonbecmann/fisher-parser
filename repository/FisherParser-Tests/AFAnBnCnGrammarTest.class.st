"
an bn cn grammar.

"
Class {
	#name : #AFAnBnCnGrammarTest,
	#superclass : #TestCase,
	#instVars : [
		'grammar'
	],
	#category : #'FisherParser-Tests-Grammar'
}

{ #category : #initialization }
AFAnBnCnGrammarTest >> setUp [
	grammar := AFExemplar anbncn
]

{ #category : #tests }
AFAnBnCnGrammarTest >> testAcceptsA2B2C2 [
	self assert: (grammar accepts: 'aabbcc')
]

{ #category : #tests }
AFAnBnCnGrammarTest >> testAcceptsABC [
	self assert: (grammar accepts: 'abc')
]

{ #category : #tests }
AFAnBnCnGrammarTest >> testAnalizeAcceptsA2B2C2 [
	| analysis chart |
	analysis := grammar analizeAccepts: 'aabbcc'.
	self assert: (analysis at: 'accepts').
	chart := analysis at: 'chart'.
	self assert: chart size equals: 7.
	self assert: chart columnSizes equals: #(7 10 10 10 9 7 6)
]

{ #category : #tests }
AFAnBnCnGrammarTest >> testAnalizeAcceptsABC [
	| analysis chart |
	analysis := grammar analizeAccepts: 'abc'.
	self assert: (analysis at: 'accepts').
	chart := analysis at: 'chart'.
	self assert: chart size equals: 4.
	self assert: chart columnSizes equals: #(6 7 7 5)
]

{ #category : #tests }
AFAnBnCnGrammarTest >> testInstanceCreation [

	self assert: grammar startNotion equals: #('an' 'bn' 'cn') asNotion.
	self
		assertCollection: grammar metanotions
		hasSameElements: #(TALLY TALLETY EMPTY LETTER) asNotions.
	self
		assertCollection: grammar protonotions
		hasSameElements: #('i' 'a' 'b' 'c' 'as' 'bs' 'cs' 's' 'symbol' 'an' 'bn' 'cn') asNotions.
	self
		assertCollection: grammar hypernotions
		hasSameElements:
			{#('i' TALLETY). #(TALLY). #(EMPTY).
			#(). #('a'). #('b'). #('c').
			#('an' 'bn' 'cn').
			#(TALLY 'as'). #(TALLY 'bs'). #(TALLY 'cs').
			#('i' TALLY LETTER 's').
			#('i' LETTER 's').
			#(TALLY LETTER 's').
			#(LETTER 'symbol').
			#('a' 'symbol'). (NCTerminal character: $a).
			#('b' 'symbol'). (NCTerminal character: $b).
			#('c' 'symbol'). (NCTerminal character: $c)} asNotions.
	self
		assertCollection: grammar terminals
		hasSameElements:
			{(NCTerminal character: $a). 
			(NCTerminal character: $b).
			(NCTerminal character: $c)}.
	self assert: grammar metaRulesSize equals: 7.
	self assert: grammar hyperRulesSize equals: 6
]
