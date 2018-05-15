Class {
	#name : #AWGrammarTest,
	#superclass : #TestCase,
	#category : #'AWijngaarden-Tests'
}

{ #category : #tests }
AWGrammarTest >> testanbncn [
	"
TALLY::		  i TALLETY.
TALLETY::	  TALLY; EMPTY.
EMPTY::		  .
LETTER::	  a; b; c.

program:	  TALLY as, TALLY bs, TALLY cs.

i TALLY LETTER s: i LETTER s, TALLY LETTER s.
i LETTER s:	  LETTER symbol.

a symbol:	  ""a"".
b symbol:	  ""b"".
c symbol:	  ""c""."

	| anbncn |
	anbncn := AVWGrammar
		metarules:
			#(	#(TALLY #('i' TALLETY)) 
				#(TALLETY #(TALLY)) 
				#(TALLETY #(EMPTY)) 
				#(EMPTY #()) 
				#(LETTER #('a')) 
				#(LETTER #('b')) 
				#(LETTER #('c')))
		hyperrules:
			#(	#(#('program') #(#(TALLY 'as') #(TALLY 'bs') #(TALLY 'cs'))) 
				#(#('i' TALLY LETTER 's') #(#('i' LETTER 's') #(TALLY LETTER 's'))) 
				#(#('i' LETTER 's') #(#(LETTER 'symbol'))) ) 
		representations:
			{	(#('a' 'symbol') -> (NCTerminal character: $a)).
				(#('b' 'symbol') -> (NCTerminal character: $b)).
				(#('c' 'symbol') -> (NCTerminal character: $c))}.
	self assert: anbncn metarulesSize equals: 7.
	self assert: anbncn metanotionsSize equals: 4.
	self assert: anbncn hyperrulesSize equals: 6.
	self assert: anbncn terminalsSize equals: 3
]
