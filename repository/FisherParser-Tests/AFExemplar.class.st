"
some typical grammar examples 
"
Class {
	#name : #AFExemplar,
	#superclass : #Object,
	#category : #'FisherParser-Tests-Grammar'
}

{ #category : #'instance creation' }
AFExemplar class >> a3b3c3 [
	^ AVWGrammar
		evw:
'TALLY::  i TALLETY.
TALLETY:: TALLY; EMPTY.
EMPTY::   .
LETTER::  a; b; c.
THREE::   iii.

program:          THREE as, THREE bs, THREE cs, stop symbol.
i TALLY LETTER s: i LETTER s, TALLY LETTER s.
i LETTER s:       LETTER symbol.'
		representations:
			{(#('a' 'symbol') -> (NCTerminal character: $a)).
			(#('b' 'symbol') -> (NCTerminal character: $b)).
			(#('c' 'symbol') -> (NCTerminal character: $c)).
			(#('stop' 'symbol') -> (NCTerminal character: $.))}
]

{ #category : #'instance creation' }
AFExemplar class >> anbncn [
	^ AVWGrammar
		evw:
'TALLY::		  i TALLETY.
TALLETY::	  TALLY; EMPTY.
EMPTY::		  .
LETTER::	  a; b; c.

program:	  TALLY as, TALLY bs, TALLY cs.

i TALLY LETTER s: i LETTER s, TALLY LETTER s.
i LETTER s:	  LETTER symbol.'
		representations:
			{	(#('a' 'symbol') -> (NCTerminal character: $a)).
				(#('b' 'symbol') -> (NCTerminal character: $b)).
				(#('c' 'symbol') -> (NCTerminal character: $c))}
]
