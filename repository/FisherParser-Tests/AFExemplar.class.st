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
AFExemplar class >> def [
	"NOTION::   ALPHA NOTETY.
NOTETY::   NOTION; EMPTY.

TAGS::	   TAG TAGSETY.
TAGSETY::  TAGS; EMPTY.
TAG::	   LETTERS tag.

LETTERS::  LETTER LETSETY.
LETSETY::  LETTERS; EMPTY.
LETTER::   letter ALPHA.

ALPHA:: a; b; c; d; e; f; g; h; i; j; k; l; m; n; o; p; q; r; s; t; u; v; w; x; y; z.

EMPTY:: .

program:
   TAGS statement sequence.

TAG TAGS statement sequence:
   TAGS statement sequence, TAG defining occurrence.

TAGS statement sequence:
   TAGS statement sequence, TAG applied occurrence,
      where TAG is in TAGS.

where TAG is in TAG TAGSETY:
   EMPTY.

where TAG1 is in TAG2 TAGS:
   where TAG1 is in TAGS.

TAG statement sequence:
   TAG defining occurrence.

TAG defining occurrence:
   define symbol, TAG.

TAG applied occurrence:
   apply symbol, TAG, <TAG assignment> option.

<NOTION> option:
   NOTION; EMPTY.

TAG assignment:
   equals symbol, value symbol.

LETTER TAG:
   LETTER symbol, TAG.

LETTER tag:
   LETTER symbol.

define symbol:	  D.
apply symbol:	  A.
value symbol:	  V.

equals symbol:	  =.

letter a symbol:  a. letter b symbol:  b. letter c symbol:  c. letter d symbol:  d. 
letter e symbol:  e. letter f symbol:  f. letter g symbol:  g. letter h symbol:  h. 
letter i symbol:  i. letter j symbol:  j. letter k symbol:  k. letter l symbol:  l.
letter m symbol:  m. letter n symbol:  n. letter o symbol:  o. letter p symbol:  p. 
letter q symbol:  q. letter r symbol:  r. letter s symbol:  s. letter t symbol:  t. 
letter u symbol:  u. letter v symbol:  v. letter w symbol:  w. letter x symbol:  x.
letter y symbol:  y. letter z symbol:  z. "

	^ AFVWGrammar
		evw:
			'NOTION::   ALPHA NOTETY.
NOTETY::   NOTION; EMPTY.

TAGS::	   TAG TAGSETY.
TAGSETY::  TAGS; EMPTY.
TAG::	   LETTERS tag.
	TAG1:: TAG.
	TAG2:: TAG.
LETTERS::  LETTER LETSETY.
LETSETY::  LETTERS; EMPTY.
LETTER::   letter ALPHA.

ALPHA:: a; b; c; d; e; f; g; h; i; j; k; l; m; n; o; p; q; r; s; t; u; v; w; x; y; z.

EMPTY:: .

program:
   TAGS statement sequence.

TAG TAGS statement sequence:
   TAGS statement sequence, TAG defining occurrence.

TAGS statement sequence:
   TAGS statement sequence, TAG applied occurrence,
      where TAG is in TAGS.

where TAG is in TAG TAGSETY: .
where TAG1 is in TAG2 TAGS:
   where TAG1 is in TAGS.

TAG statement sequence:
   TAG defining occurrence.

TAG defining occurrence:
   define symbol, TAG.

TAG applied occurrence:
   apply symbol, TAG, <TAG assignment> option.

<NOTION> option: NOTION; .

TAG assignment:
   equals symbol, value symbol.

LETTER TAG:
   LETTER symbol, TAG.

LETTER tag:
   LETTER symbol.'
		representations:
			{(#('define' 'symbol') -> (NCTerminal character: $D)).
			(#('apply' 'symbol') -> (NCTerminal character: $A)).
			(#('value' 'symbol') -> (NCTerminal character: $V)).
			(#('equals' 'symbol') -> (NCTerminal character: $=))}
				,
					(($a to: $z)
						collect: [ :char | 
							{'letter'.
							char asString.
							'symbol'} -> (NCTerminal character: char) ])
]

{ #category : #'instance creation' }
AFExemplar class >> doubleLettersB [
	" first W-grammar description of double letters "

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
AFExemplar class >> doubleLettersC [
	" second W-grammar description of double letters "

	^ AFVWGrammar
		evw:
'ALPHA:: a; b; c; d; e; f; g; h; i; j; k; l; m; n; o; p; q; r; s; t; u; v; w; x; y; z.
ALPHA1:: ALPHA.
ALPHA2:: ALPHA.

double letters: letter ALPHA1 symbol, letter ALPHA2 symbol, where ALPHA1 is ALPHA2.
where ALPHA is ALPHA: .'
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
AFExemplar class >> equal [
	^ AFVWGrammar
		evw:
'VALUE::	 i VALETY.
VALETY:: VALUE; EMPTY.
EMPTY::	 .
VALUE1:: VALUE.
VALUE2:: VALUE.

equal program:
	VALUE primary, equals symbol, VALUE expression.

VALUE expression:
	VALUE primary;
	VALUE1 primary, plus symbol, VALUE2 primary, where VALUE1 plus VALUE2 equals VALUE;
	twice symbol, VALUE1 primary, where VALUE1 plus VALUE1 equals VALUE.

VALUE primary:
	VALUE constant;
	lpar symbol, VALUE expression, rpar symbol.

VALUE constant: VALUE eyes.

i eyes: i symbol.
i VALUE eyes: i eyes, VALUE eyes.

where VALUE1 plus VALUE2 equals VALUE1 VALUE2: .'
		representations:
			{(#('equals' 'symbol') -> (NCTerminal character: $=)).
			(#('plus' 'symbol') -> (NCTerminal character: $+)).
			(#('twice' 'symbol') -> (NCTerminal character: $2)).
			(#('lpar' 'symbol') -> (NCTerminal character: $()).
			(#('rpar' 'symbol') -> (NCTerminal character: $))).
			(#('i' 'symbol') -> (NCTerminal character: $i))}
]

{ #category : #'instance creation' }
AFExemplar class >> leftRecursiveAnbncn [
	^ AFVWGrammar
		evw:
'TALLY::		  i TALLETY.
TALLETY::	  TALLY; EMPTY.
EMPTY::		  .
LETTER::	  a; b; c.

an bn cn:	  TALLY as, TALLY bs, TALLY cs.

i TALLY LETTER s: TALLY LETTER s, i LETTER s.
i LETTER s:	  LETTER symbol.'
		representations:
			{(#('a' 'symbol') -> (NCTerminal character: $a)).
			(#('b' 'symbol') -> (NCTerminal character: $b)).
			(#('c' 'symbol') -> (NCTerminal character: $c))}
]

{ #category : #'instance creation' }
AFExemplar class >> nd [
	" a w-grammar that describes all alphabetic character strings in which no letter is repeated. "
	^ AFVWGrammar
		evw:
'ALPHA:: a; b; c; d; e; f; g; h; i; j; k; l; m; n; o; p; q; r; s; t; u; v; w; x; y; z.
LETTER:: letter ALPHA.
TAG:: LETTER TAGETY. 
	TAGETY:: TAG; .
NOTION:: ALPHA NOTETY.
	NOTETY:: NOTION; .

LETTER1:: LETTER.
LETTER2:: LETTER.
ALPHA1:: ALPHA.
ALPHA2:: ALPHA.
NOTETY1:: NOTETY.
NOTETY2:: NOTETY.
NOTETY3:: NOTETY.

s: 	TAG unique.

LETTER TAG unique: LETTER symbol, TAG unique, where LETTER is not in TAG.
LETTER unique: 	LETTER symbol.

where LETTER1 is not in LETTER2 TAG:
	where LETTER1 isnt LETTER2, where LETTER1 is not in TAG.
where LETTER1 is not in LETTER2:
	where LETTER1 isnt LETTER2.

where letter ALPHA1 isnt letter ALPHA2: 
	where ALPHA1 precedes ALPHA2 in abcdefghijklmnopqrstuvwxyz;
	where ALPHA2 precedes ALPHA1 in abcdefghijklmnopqrstuvwxyz.

where ALPHA1 precedes ALPHA2 in NOTETY1 ALPHA1 NOTETY2 ALPHA2 NOTETY3: .'
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
AFExemplar class >> pl [
	" w-grammar description of two-letters strings, the first letter precedes the second in the alphabet. "
	^ AFVWGrammar
		evw:
'ALPHA:: a; b; c; d; e; f; g; h; i; j; k; l; m; n; o; p; q; r; s; t; u; v; w; x; y; z.
ALPHA1:: ALPHA.
ALPHA2:: ALPHA.
NOTETY:: ALPHA NOTETY; .
NOTETY1:: NOTETY.
NOTETY2:: NOTETY.
NOTETY3:: NOTETY.

s: 	letter ALPHA1 symbol, letter ALPHA2 symbol, where ALPHA1 precedes ALPHA2 in abcdefghijklmnopqrstuvwxyz.
	
where ALPHA1 precedes ALPHA2 in NOTETY1 ALPHA1 NOTETY2 ALPHA2 NOTETY3: .'
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
