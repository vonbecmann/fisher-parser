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
	^ AFVWGrammar 
		evw:
'TALLY::  i TALLETY.
TALLETY:: TALLY; EMPTY.
EMPTY::   .
LETTER::  a; b; c.
THREE::   iii.

three as three bs three cs: 	THREE as, THREE bs, THREE cs, stop symbol.
i TALLY LETTER s: 					i LETTER s, TALLY LETTER s.
i LETTER s:       					LETTER symbol.'
		representations:
			{(#('a' 'symbol') -> (NCTerminal character: $a)).
			(#('b' 'symbol') -> (NCTerminal character: $b)).
			(#('c' 'symbol') -> (NCTerminal character: $c)).
			(#('stop' 'symbol') -> (NCTerminal character: $.))}
]

{ #category : #'instance creation' }
AFExemplar class >> anbn [
	" P grammar : page 62
N:: n;	 Nn.

s: 		Na, Nb.
nNa: 	letter a symbol, Na.
nNb: 	letter b symbol, Nb.
na: 	letter a symbol.
nb: 	letter b symbol.	"
	^ AFVWGrammar 
		evw: 
'N:: n;	 Nn.

s: 		Na, Nb.
nNa: 	letter a symbol, Na.
nNb: 	letter b symbol, Nb.
na: 	letter a symbol.
nb: 	letter b symbol.' 
		representations: 
			{(#('letter' 'a' 'symbol') -> (NCTerminal character: $a)).
			(#('letter' 'b' 'symbol') -> (NCTerminal character: $b))}
]

{ #category : #'instance creation' }
AFExemplar class >> anbncn [
	^ AFVWGrammar
		evw:
'TALLY::		  i TALLETY.
TALLETY::	  TALLY; EMPTY.
EMPTY::		  .
LETTER::	  a; b; c.

an bn cn:	  TALLY as, TALLY bs, TALLY cs.

i TALLY LETTER s: i LETTER s, TALLY LETTER s.
i LETTER s:	  LETTER symbol.'
		representations:
			{(#('a' 'symbol') -> (NCTerminal character: $a)).
			(#('b' 'symbol') -> (NCTerminal character: $b)).
			(#('c' 'symbol') -> (NCTerminal character: $c))}
]

{ #category : #'instance creation' }
AFExemplar class >> starSequence [
	"
EMPTY:: .
program: star seq, star symbol.
star seq: star symbol, star seq; EMPTY.
star symbol:   '*'.
	"

	^ AFVWGrammar
		evw:
'EMPTY:: .
program: 		star seq, star symbol.
star seq: 	star symbol, star seq; EMPTY.'
		representations: {(#('star' 'symbol') -> (NCTerminal character: $*))}
]

{ #category : #'instance creation' }
AFExemplar class >> test15 [
	"
ALPHA::	  i.
BETA::	  i.

program:  ALPHA.
BETA:	  x symbol.
x symbol: 'x'. "

	^ AFVWGrammar
		evw:
'ALPHA::	  i.
BETA::	  i.

program:  ALPHA.
BETA:	  x symbol.'
		representations: 
			{(#('x' 'symbol') -> (NCTerminal character: $x))}
]

{ #category : #'instance creation' }
AFExemplar class >> test3 [
	"
LETTER::  h; i; j.
NOTION::  LETTER NOTETY.
NOTETY::  NOTION; EMPTY.
EMPTY::   .

program:  LETTER1 symbol, LETTER2 symbol, LETTER3 symbol,
          where <LETTER1> is <LETTER2>,
          where <LETTER2> is <LETTER3>.

where <NOTION> is <NOTION>: EMPTY. 

h symbol:         'h'.
i symbol:         'i'.
j symbol:         'j'."

	" i replace 
	this hyper rule:  where <NOTION> is <NOTION>: EMPTY.
	with:             where <NOTION> is <NOTION>: .  "

	^ AFVWGrammar
		evw:
			'LETTER::  h; i; j.
NOTION::  LETTER NOTETY.
NOTETY::  NOTION; EMPTY.
EMPTY::   .
LETTER1:: LETTER.
LETTER2:: LETTER.
LETTER3:: LETTER.

program:  LETTER1 symbol, LETTER2 symbol, LETTER3 symbol,
          where <LETTER1> is <LETTER2>,
          where <LETTER2> is <LETTER3>.

where <NOTION> is <NOTION>: .'
		representations:
			{(#('h' 'symbol') -> (NCTerminal character: $h)).
			(#('i' 'symbol') -> (NCTerminal character: $i)).
			(#('j' 'symbol') -> (NCTerminal character: $j))}
]

{ #category : #'instance creation' }
AFExemplar class >> test4 [
	"
LETTER::  h; i; j.

program:  LETTER thing.

LETTER thing: LETTER symbol, LETTER symbol, LETTER symbol.

h symbol:         'Percy'.
i symbol:         'Jim'.
j symbol:         'Terry'."

	^ AFVWGrammar
		evw:
'LETTER::  h; i; j.

program:  LETTER thing.
LETTER thing: LETTER symbol, LETTER symbol, LETTER symbol.'
		representations: 
			{(#('h' 'symbol') -> (NCTerminal character: $h)).
			(#('i' 'symbol') -> (NCTerminal character: $i)).
			(#('j' 'symbol') -> (NCTerminal character: $j))}
]

{ #category : #'instance creation' }
AFExemplar class >> wegner [
	"
BETY::	 b BETY; EMPTY.
EMPTY::	 .

program:	  growing.

growing BETY: 	a symbol, growing b BETY, c symbol;
					terminal BETY.

terminal b BETY: 	b symbol, terminal BETY.
terminal b: 			b symbol.

a symbol:   a.
b symbol:   b.
c symbol:   c. "
	^ AFVWGrammar
		evw:
'BETY::	 b BETY; EMPTY.
EMPTY::	 .

program:	  growing.

growing BETY: 	a symbol, growing b BETY, c symbol;
					terminal BETY.

terminal b BETY: 	b symbol, terminal BETY.
terminal b: 			b symbol.'
		representations: 
			{(#('a' 'symbol') -> (NCTerminal character: $a)).
			(#('b' 'symbol') -> (NCTerminal character: $b)).
			(#('c' 'symbol') -> (NCTerminal character: $c))}
]
