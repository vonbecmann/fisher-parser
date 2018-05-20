Class {
	#name : #AWGrammarTest,
	#superclass : #TestCase,
	#category : #'EarleyVW-Tests'
}

{ #category : #tests }
AWGrammarTest >> testDuplicatedHyperRule [
	| duplicatedHyperRuleGrammar |
	duplicatedHyperRuleGrammar := AVWGrammar
		evw:
'EMPTY:: 	.

program:	  TALLY as, TALLY bs, TALLY cs.
program:	  TALLY as, TALLY bs, TALLY cs.'
		representations:
			{(#('a' 'symbol') -> (NCTerminal character: $a)).
			(#('b' 'symbol') -> (NCTerminal character: $b)).
			(#('c' 'symbol') -> (NCTerminal character: $c))}.
	self assert: duplicatedHyperRuleGrammar metaRulesSize equals: 1.
	self assert: duplicatedHyperRuleGrammar hyperRulesSize equals: 4
]

{ #category : #tests }
AWGrammarTest >> testDuplicatedHyperRule02 [
	| duplicatedHyperRuleGrammar |
	duplicatedHyperRuleGrammar := AVWGrammar
		evw: 'EMPTY::. program: .'
		representations:
			{(#('a' 'symbol') -> (NCTerminal character: $a)).
			(#('a' 'symbol') -> (NCTerminal character: $a)).
			(#('b' 'symbol') -> (NCTerminal character: $b)).
			(#('c' 'symbol') -> (NCTerminal character: $c))}.
	self assert: duplicatedHyperRuleGrammar metaRulesSize equals: 1.
	self assert: duplicatedHyperRuleGrammar hyperRulesSize equals: 4
]

{ #category : #tests }
AWGrammarTest >> testDuplicatedMetaRule [
	| duplicatedMetaRuleGrammar |
	duplicatedMetaRuleGrammar := AVWGrammar
		evw:
'TALLY::		  i TALLETY.
TALLY::		  i TALLETY.
TALLETY::	  TALLY; EMPTY.
EMPTY::		  .

program:	 .'
		representations:
			{(#('a' 'symbol') -> (NCTerminal character: $a)).
			(#('b' 'symbol') -> (NCTerminal character: $b)).
			(#('c' 'symbol') -> (NCTerminal character: $c))}.
	self assert: duplicatedMetaRuleGrammar metaRulesSize equals: 4.
	self assert: duplicatedMetaRuleGrammar hyperRulesSize equals: 4
]

{ #category : #tests }
AWGrammarTest >> testRepresentationsIsEmpty [
	self 
		should: [ AVWGrammar evw: 'EMPTY:: . program: .' representations: #() ] 
		raise: Error
]

{ #category : #tests }
AWGrammarTest >> testanbncn [
	| anbncn |
	anbncn := AVWGrammar
		evw: 
'TALLY::		  i TALLETY.
TALLETY::	  TALLY; EMPTY.
EMPTY::		  .
LETTER::	  a; b; c.

anbncn:	  TALLY as, TALLY bs, TALLY cs.

i TALLY LETTER s: i LETTER s, TALLY LETTER s.
i LETTER s:	  LETTER symbol.'
		representations:
			{	(#('a' 'symbol') -> (NCTerminal character: $a)).
				(#('b' 'symbol') -> (NCTerminal character: $b)).
				(#('c' 'symbol') -> (NCTerminal character: $c))}.
	self assert: anbncn startNotion equals: (AWHypernotion with: 'anbncn' asNotion).
	self 
		assertCollection: anbncn metanotions
		hasSameElements: (#(TALLY TALLETY EMPTY LETTER) collect: [ :each | each asNotion ]).
	self 
		assertCollection: anbncn protonotions
		hasSameElements: 
			(#('i' 'a' 'b' 'c' 'anbncn' 'as' 'bs' 'cs' 's' 'symbol')
				collect: [ :each | each asNotion ]).
	self 
		assertCollection: anbncn hypernotions 
		hasSameElements: {
			#('i' TALLETY) asNotion.	#(TALLY) asNotion. #(EMPTY) asNotion.
			#() asNotion. #('a') asNotion. #('b') asNotion. #('c') asNotion.
			#('anbncn') asNotion. 
			#(TALLY 'as') asNotion. #(TALLY 'bs') asNotion. #(TALLY 'cs') asNotion. 
			#('i' TALLY LETTER 's') asNotion.
			#('i' LETTER 's') asNotion. #(TALLY LETTER 's') asNotion. 
			#(LETTER 'symbol') asNotion.
			#('a' 'symbol') asNotion.  (NCTerminal character: $a) asNotion.
			#('b' 'symbol') asNotion. (NCTerminal character: $b) asNotion.
			#('c' 'symbol') asNotion. (NCTerminal character: $c) asNotion}.
	self 
		assertCollection: anbncn terminals 
		hasSameElements: {(NCTerminal character: $a). 
								(NCTerminal character: $b).
								(NCTerminal character: $c)}.
	self assert: anbncn metaRulesSize equals: 7.
	self assert: anbncn hyperRulesSize equals: 6.
	
]
