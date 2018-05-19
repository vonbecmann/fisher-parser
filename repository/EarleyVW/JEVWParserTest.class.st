Class {
	#name : #JEVWParserTest,
	#superclass : #TestCase,
	#category : #'EarleyVW-Tests'
}

{ #category : #tests }
JEVWParserTest >> testAnBnCn [
	| anbncn |
	anbncn := AVWGrammar
		evw:
'TALLY::		  i TALLETY.
TALLETY::	  TALLY; EMPTY.
EMPTY::		  .
LETTER::	  a; b; c.

program:	  TALLY as, TALLY bs, TALLY cs.

i TALLY LETTER s: i LETTER s, TALLY LETTER s.
i LETTER s:	  LETTER symbol.'
		representations:
			{(#('a' 'symbol') -> (NCTerminal character: $a)).
			(#('b' 'symbol') -> (NCTerminal character: $b)).
			(#('c' 'symbol') -> (NCTerminal character: $c))}.
	self assert: anbncn metaRulesSize equals: 7.
	self assert: anbncn metanotionsSize equals: 4.
	self assert: anbncn hyperRulesSize equals: 6.
	self assert: anbncn terminalsSize equals: 3
]
