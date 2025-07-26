Class {
	#name : 'AWGrammarTest',
	#superclass : 'TestCase',
	#category : 'EarleyVW-Tests',
	#package : 'EarleyVW',
	#tag : 'Tests'
}

{ #category : 'tests' }
AWGrammarTest >> testDuplicatedHyperRule [
	| duplicatedHyperRuleGrammar |
	duplicatedHyperRuleGrammar := AVWGrammar
		evw:
'TALLY:: .

program:	  TALLY as, TALLY bs, TALLY cs.
program:	  TALLY as, TALLY bs, TALLY cs.'
		representations:
			{(#('a' 'symbol') -> (NCTerminal character: $a)).
			(#('b' 'symbol') -> (NCTerminal character: $b)).
			(#('c' 'symbol') -> (NCTerminal character: $c))}.
	self assert: duplicatedHyperRuleGrammar metaRulesSize equals: 1.
	self assert: duplicatedHyperRuleGrammar hyperRulesSize equals: 4
]

{ #category : 'tests' }
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

{ #category : 'tests' }
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

{ #category : 'tests' }
AWGrammarTest >> testRepresentationsIsEmpty [
	self 
		should: [ AVWGrammar evw: 'EMPTY:: . program: .' representations: #() ] 
		raise: Error
]

{ #category : 'tests' }
AWGrammarTest >> testTest3 [
	| test3 |
	test3 :=
			AVWGrammar
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

where <NOTION> is <NOTION>: EMPTY.'
				representations:
					{(#('h' 'symbol') -> (NCTerminal character: $h)).
					(#('i' 'symbol') -> (NCTerminal character: $i)).
					(#('j' 'symbol') -> (NCTerminal character: $j))} .

	self assert: test3 startNotion equals: (AWHypernotion with: 'program' asNotion).
	self 
		assertCollection: test3 metanotions
		hasSameElements: #(LETTER LETTER1 LETTER2 LETTER3 NOTION NOTETY EMPTY) asNotions.
]

{ #category : 'tests' }
AWGrammarTest >> testUnknownMetanotion [
	self
		should: [ 
			AVWGrammar
				evw:
'LETTER::  h; i; j.
NOTION::  LETTER NOTETY.
NOTETY::  NOTION; EMPTY.
EMPTY::   .

program:  LETTER1 symbol, LETTER2 symbol, LETTER3 symbol,
          where <LETTER1> is <LETTER2>,
          where <LETTER2> is <LETTER3>.

where <NOTION> is <NOTION>: EMPTY.'
				representations:
					{(#('h' 'symbol') -> (NCTerminal character: $h)).
					(#('i' 'symbol') -> (NCTerminal character: $i)).
					(#('j' 'symbol') -> (NCTerminal character: $j))} ]
		raise: Error
		withExceptionDo: [ :ex |
			self 
				assert: ex messageText  
				equals: 'Unknown Metanotion LETTER1 in LETTER1 symbol'
			 ].
]

{ #category : 'tests' }
AWGrammarTest >> testUnknownMetanotion02 [
	self
		should: [ 
			AVWGrammar
				evw:
'LETTER::  h; i; j.
NOTION::  LETTER NOTETY.
NOTETY::  NOTION; EMPTY.
EMPTY::   .
LETTER1:: LETTER.

program:  LETTER1 symbol, LETTER2 symbol, LETTER3 symbol,
          where <LETTER1> is <LETTER2>,
          where <LETTER2> is <LETTER3>.

where <NOTION> is <NOTION>: EMPTY.'
				representations:
					{(#('h' 'symbol') -> (NCTerminal character: $h)).
					(#('i' 'symbol') -> (NCTerminal character: $i)).
					(#('j' 'symbol') -> (NCTerminal character: $j))} ]
		raise: Error
		withExceptionDo: [ :ex |
			self 
				assert: ex messageText  
				equals: 'Unknown Metanotion LETTER2 in LETTER2 symbol'
			 ].
]

{ #category : 'tests' }
AWGrammarTest >> testUnknownMetanotion03 [
	self
		should: [ 
			AVWGrammar
				evw:
'LETTER::  h; i; j.
NOTION::  LETTER NOTETY.
NOTETY::  NOTION; EMPTY.
EMPTY::   .
LETTER1:: LETTER.
LETTER2:: LETTER.

program:  LETTER1 symbol, LETTER2 symbol, LETTER3 symbol,
          where <LETTER1> is <LETTER2>,
          where <LETTER2> is <LETTER3>.

where <NOTION> is <NOTION>: EMPTY.'
				representations:
					{(#('h' 'symbol') -> (NCTerminal character: $h)).
					(#('i' 'symbol') -> (NCTerminal character: $i)).
					(#('j' 'symbol') -> (NCTerminal character: $j))} ]
		raise: Error
		withExceptionDo: [ :ex |
			self 
				assert: ex messageText  
				equals: 'Unknown Metanotion LETTER3 in LETTER3 symbol'
			 ].
]

{ #category : 'tests' }
AWGrammarTest >> testUnknownMetanotion04 [
	self
		should: [ 
			AVWGrammar
				evw:
'LETTER::  h; i; j.
NOTION::  LETTER NOTETY.
NOTETY::  NOTION; EMPTY.

LETTER1:: LETTER.
LETTER2:: LETTER.
LETTER3:: LETTER.

program:  LETTER1 symbol, LETTER2 symbol, LETTER3 symbol,
          where <LETTER1> is <LETTER2>,
          where <LETTER2> is <LETTER3>.

where <NOTION> is <NOTION>: EMPTY.'
				representations:
					{(#('h' 'symbol') -> (NCTerminal character: $h)).
					(#('i' 'symbol') -> (NCTerminal character: $i)).
					(#('j' 'symbol') -> (NCTerminal character: $j))} ]
		raise: Error
		withExceptionDo: [ :ex |
			self 
				assert: ex messageText  
				equals: 'Unknown Metanotion EMPTY in EMPTY'
			 ].
]

{ #category : 'tests' }
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
		hasSameElements: #(TALLY TALLETY EMPTY LETTER) asNotions.
	self 
		assertCollection: anbncn protonotions
		hasSameElements: #('i' 'a' 'b' 'c' 'anbncn' 'as' 'bs' 'cs' 's' 'symbol') asNotions.
	self 
		assertCollection: anbncn hypernotions 
		hasSameElements: {
			#('i' TALLETY).	#(TALLY). #(EMPTY).
			#(). #('a'). #('b'). #('c').
			#('anbncn'). 
			#(TALLY 'as'). #(TALLY 'bs'). #(TALLY 'cs'). 
			#('i' TALLY LETTER 's').
			#('i' LETTER 's'). #(TALLY LETTER 's'). 
			#(LETTER 'symbol').
			#('a' 'symbol').  (NCTerminal character: $a).
			#('b' 'symbol'). (NCTerminal character: $b).
			#('c' 'symbol'). (NCTerminal character: $c)} asNotions.
	self 
		assertCollection: anbncn terminals 
		hasSameElements: {(NCTerminal character: $a). 
								(NCTerminal character: $b).
								(NCTerminal character: $c)}.
	self assert: anbncn metaRulesSize equals: 7.
	self assert: anbncn hyperRulesSize equals: 6.
	
]
