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
		" introduce NETY so N metanotion is LL(1) "
	^ AFVWGrammar 
		evw: 
'N:: n NETY.
NETY:: N; .

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
AFExemplar class >> doubleLettersB [
	^ AFVWGrammar
		evw:
'ALPHA:: a; b; c; d; e; f; g; h; i; j; k; l; m; n; o; p; q; r; s; t; u; v; w; x; y; z.

double letters: letter ALPHA symbol, letter ALPHA symbol.'
		representations:
			{(#('letter' 'a' 'symbol') -> (NCTerminal character: $a)).
			(#('letter' 'b' 'symbol') -> (NCTerminal character: $b)).
			(#('letter' 'c' 'symbol') -> (NCTerminal character: $c)).
			(#('letter' 'd' 'symbol') -> (NCTerminal character: $d)).
			(#('letter' 'e' 'symbol') -> (NCTerminal character: $e)).
			(#('letter' 'f' 'symbol') -> (NCTerminal character: $f)).
			(#('letter' 'g' 'symbol') -> (NCTerminal character: $g)).
			(#('letter' 'h' 'symbol') -> (NCTerminal character: $h)).
			(#('letter' 'i' 'symbol') -> (NCTerminal character: $i)).
			(#('letter' 'j' 'symbol') -> (NCTerminal character: $j)).
			(#('letter' 'k' 'symbol') -> (NCTerminal character: $k)).
			(#('letter' 'l' 'symbol') -> (NCTerminal character: $l)).
			(#('letter' 'm' 'symbol') -> (NCTerminal character: $m)).
			(#('letter' 'n' 'symbol') -> (NCTerminal character: $n)).
			(#('letter' 'o' 'symbol') -> (NCTerminal character: $o)).
			(#('letter' 'p' 'symbol') -> (NCTerminal character: $p)).
			(#('letter' 'q' 'symbol') -> (NCTerminal character: $q)).
			(#('letter' 'r' 'symbol') -> (NCTerminal character: $r)).
			(#('letter' 's' 'symbol') -> (NCTerminal character: $s)).
			(#('letter' 't' 'symbol') -> (NCTerminal character: $t)).
			(#('letter' 'u' 'symbol') -> (NCTerminal character: $u)).
			(#('letter' 'v' 'symbol') -> (NCTerminal character: $v)).
			(#('letter' 'w' 'symbol') -> (NCTerminal character: $w)).
			(#('letter' 'x' 'symbol') -> (NCTerminal character: $x)).
			(#('letter' 'y' 'symbol') -> (NCTerminal character: $y)).
			(#('letter' 'z' 'symbol') -> (NCTerminal character: $z))}
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
AFExemplar class >> test5 [
	^ AFVWGrammar
		evw:
'EMPTY::  .

NOTION:: ALPHA NOTETY; <NOTION>.
NOTETY:: NOTION; EMPTY.
ALPHA:: a;b;c;d;e;f;g;h;i;j;k;l;m;n;o;p;q;r;s;t;u;v;w;x;y;z.

program:          abc.

abc:              pack of <abc>; star symbol.

pack of <NOTION>: lpar symbol, NOTION, rpar symbol.'
		representations:
			{(#('lpar' 'symbol') -> (NCTerminal character: $()).
			(#('rpar' 'symbol') -> (NCTerminal character: $))).
			(#('star' 'symbol') -> (NCTerminal character: $*))}
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
