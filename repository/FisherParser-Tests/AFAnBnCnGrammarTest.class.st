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
AFAnBnCnGrammarTest >> testInstanceCreation [

	self assert: grammar startNotion equals: (AWHypernotion with: 'start' asNotion).
	self
		assertCollection: grammar metanotions
		hasSameElements: (#(TALLY TALLETY EMPTY LETTER) collect: [ :each | each asNotion ]).
	self
		assertCollection: grammar protonotions
		hasSameElements:
			(#('i' 'a' 'b' 'c' 'program' 'as' 'bs' 'cs' 's' 'symbol')
				collect: [ :each | each asNotion ]).
	self
		assertCollection: grammar hypernotions
		hasSameElements:
			{#('i' TALLETY) asNotion. #(TALLY) asNotion. #(EMPTY) asNotion.
			#() asNotion. #('a') asNotion. #('b') asNotion. #('c') asNotion.
			#('program') asNotion.
			#(TALLY 'as') asNotion. #(TALLY 'bs') asNotion. #(TALLY 'cs') asNotion.
			#('i' TALLY LETTER 's') asNotion.
			#('i' LETTER 's') asNotion.
			#(TALLY LETTER 's') asNotion.
			#(LETTER 'symbol') asNotion.
			#('a' 'symbol') asNotion. (NCTerminal character: $a) asNotion.
			#('b' 'symbol') asNotion. (NCTerminal character: $b) asNotion.
			#('c' 'symbol') asNotion. (NCTerminal character: $c) asNotion}.
	self
		assertCollection: grammar terminals
		hasSameElements:
			{(NCTerminal character: $a). 
			(NCTerminal character: $b).
			(NCTerminal character: $c)}.
	self assert: grammar metaRulesSize equals: 7.
	self assert: grammar hyperRulesSize equals: 6
]
