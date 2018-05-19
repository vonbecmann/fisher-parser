Class {
	#name : #AWGrammarTest,
	#superclass : #TestCase,
	#category : #'AWijngaarden-Tests'
}

{ #category : #tests }
AWGrammarTest >> testRepresentationsIsEmpty [
	self 
		should: 
			[ AVWGrammar 
				metaRules: #(#(EMPTY #())) 
				hyperRules: #(#(#('program') #())) 
				representations: #() ] 
		raise: Error
]

{ #category : #tests }
AWGrammarTest >> testanbncn [
	| anbncn |
	anbncn := AVWGrammar
		metaRules:
			#(	#(TALLY #('i' TALLETY)) 
				#(TALLETY #(TALLY)) 
				#(TALLETY #(EMPTY)) 
				#(EMPTY #()) 
				#(LETTER #('a')) 
				#(LETTER #('b')) 
				#(LETTER #('c')))
		hyperRules:
			#(	#(#('program') #(#(TALLY 'as') #(TALLY 'bs') #(TALLY 'cs'))) 
				#(#('i' TALLY LETTER 's') #(#('i' LETTER 's') #(TALLY LETTER 's'))) 
				#(#('i' LETTER 's') #(#(LETTER 'symbol'))) ) 
		representations:
			{	(#('a' 'symbol') -> (NCTerminal character: $a)).
				(#('b' 'symbol') -> (NCTerminal character: $b)).
				(#('c' 'symbol') -> (NCTerminal character: $c))}.
	self assert: anbncn startNotion equals: (AWHypernotion with: 'program' asNotion).
	self assert: anbncn metanotionsSize equals: 4.
	self 
		assertCollection: anbncn metanotions
		hasSameElements: (#(TALLY TALLETY EMPTY LETTER) collect: [ :each | each asNotion ]).
	self assert: anbncn protonotionSize equals: 10.
	self 
		assertCollection: anbncn protonotions
		hasSameElements: 
			(#('i' 'a' 'b' 'c' 'program' 'as' 'bs' 'cs' 's' 'symbol')
				collect: [ :each | each asNotion ]).
	self assert: anbncn hypernotionsSize equals: 21.
	self 
		assertCollection: anbncn hypernotions 
		hasSameElements: {
			#('i' TALLETY) asNotion.	#(TALLY) asNotion. #(EMPTY) asNotion.
			#() asNotion. #('a') asNotion. #('b') asNotion. #('c') asNotion.
			#('program') asNotion. 
			#(TALLY 'as') asNotion. #(TALLY 'bs') asNotion. #(TALLY 'cs') asNotion. 
			#('i' TALLY LETTER 's') asNotion.
			#('i' LETTER 's') asNotion. #(TALLY LETTER 's') asNotion. 
			#(LETTER 'symbol') asNotion.
			#('a' 'symbol') asNotion.  (NCTerminal character: $a) asNotion.
			#('b' 'symbol') asNotion. (NCTerminal character: $b) asNotion.
			#('c' 'symbol') asNotion. (NCTerminal character: $c) asNotion}.
	self assert: anbncn terminalsSize equals: 3.
	self 
		assertCollection: anbncn terminals 
		hasSameElements: {(NCTerminal character: $a). 
								(NCTerminal character: $b).
								(NCTerminal character: $c)}.
	self assert: anbncn metaRulesSize equals: 7.
	self assert: anbncn hyperRulesSize equals: 6.
	
]
