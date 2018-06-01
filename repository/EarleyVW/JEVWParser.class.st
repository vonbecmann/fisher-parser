"
an earley VW grammar (two level grammar) parser.
see vwGrammar method on class side.



"
Class {
	#name : #JEVWParser,
	#superclass : #Object,
	#instVars : [
		'evaluator'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'EarleyVW-Core'
}

{ #category : #accessing }
JEVWParser class >> instance [
	^ instance ifNil: [ instance := self new ]
]

{ #category : #accessing }
JEVWParser class >> reset [
	instance := nil
]

{ #category : #grammar }
JEVWParser class >> vwEvaluator [
	^ ESSingleSynthesizedAttributeEvaluator grammar: self vwGrammar actions: 
{
(('vw grammar' -> 1) -> [ :nodes | Array with: nodes first with: nodes third ]).
(('metaproductions' -> 2) 
	-> [ :nodes | Array streamContents: [ :s | s nextPutAll: nodes first; nextPutAll: nodes third ]]).
(('metaproduction rule' -> 1) 
	-> [ :nodes | nodes fifth collect: [ :each | AWMetaProductionRule head: nodes first body: each ]]).
(('hypernotion alternatives' -> 1) -> [ :node | Array with: node ]).
(('hypernotion alternatives' -> 2) 
	-> [ :nodes | Array streamContents: [:s | s nextPutAll: nodes first; nextPut: nodes fourth ]]).
(('hypernotion option' -> 2) -> [ AWHypernotion new ]).
(('hyper rules' -> 2) 
	-> [ :nodes | Array streamContents: [ :s | s nextPutAll: nodes first; nextPutAll: nodes third ]]).
(('hyper rule' -> 1) 
	-> [ :nodes | nodes fourth collect: [ :each | AWHyperRule head: nodes first body: each ]]).
(('hyperalternatives' -> 1) -> [ :node | Array with: node ]).
(('hyperalternatives' -> 2) 
	-> [ :nodes | Array streamContents: [ :s | s nextPutAll: nodes first; nextPut: nodes fourth ]]).
(('hyperalternative option' -> 2) -> [ Array empty ]).
(('hyperalternative' -> 1) -> [ :node | Array with: node ]).
(('hyperalternative' -> 2)
	-> [ :nodes | Array streamContents: [ :s | s nextPutAll: nodes first; nextPut: nodes fourth ]]).
(('hypernotion' -> 1) -> [ :nodes | AWHypernotion withAll: nodes ]).
(('protonotion then metanotion' -> 1) -> [ :node | Array with: node ]).
(('protonotion then metanotion' -> 2)
	-> [ :nodes | Array streamContents: [ :s | s nextPut: nodes first; nextPutAll: nodes second ]]).
(('protonotion then metanotion' -> 3)
	-> [ :nodes | Array streamContents: [ :s | s nextPut: nodes first; nextPutAll: nodes third ]]).
(('metanotion then protonotion' -> 1) -> [ :node | Array with: node ]).
(('metanotion then protonotion' -> 2)
	-> [ :nodes | Array streamContents: [ :s | s nextPut: nodes first; nextPutAll: nodes second ]]).
(('metanotion then protonotion' -> 3)
	-> [ :nodes | Array streamContents: [ :s | s nextPut: nodes first; nextPutAll: nodes third ]]).
(('metanotion' -> 1) -> [ :node | AWMetanotion named: node ]).
(('large syntactic mark plus' -> 2) 
	-> [ :nodes | 
			String streamContents: [ :s | s nextPutAll: nodes first; nextPutAll: nodes second ] ]).
(('protonotion' -> 1) -> [ :node | AWProtonotion with: node ]).
(('small syntactic mark plus' -> 2) 
	-> [ :nodes | 
			String streamContents: [ :s | s nextPutAll: nodes first; nextPutAll: nodes second ] ]).
(('layout' -> 1) -> [ nil ]).
(('layout' -> 2) -> [ nil ]).
(('separator plus' -> 1) -> [ nil ]).
(('separator plus' -> 2) -> [ nil ]).
(('small syntactic mark symbol' -> 1) -> [ :node | String with: node ]).
(('large syntactic mark symbol' -> 1) -> [ :node | String with: node ]). }
]

{ #category : #grammar }
JEVWParser class >> vwGrammar [
	^ JEGrammar
		e1vw: 
'vw grammar: metaproductions, layout, hyper rules.

metaproductions:
	metaproduction rule;
	metaproductions, layout, metaproduction rule.
metaproduction rule:
	metanotion, colon symbol, colon symbol, layout, hypernotion alternatives, dot symbol.
hypernotion alternatives: 
	hypernotion option;
	hypernotion alternatives, semicolon symbol, layout, hypernotion option.
hypernotion option: hypernotion; .

hyper rules:
	hyper rule;
	hyper rules, layout, hyper rule.
hyper rule:
	hypernotion, colon symbol, layout, hyperalternatives, dot symbol.
hyperalternatives:
	hyperalternative option;
	hyperalternatives, semicolon symbol, layout, hyperalternative option.
hyperalternative option: hyperalternative; .
hyperalternative: 
	hypernotion;
	hyperalternative, comma symbol, layout, hypernotion.

hypernotion: (protonotion or metanotion) plus.

(protonotion or metanotion) plus:
	protonotion then metanotion; 
	metanotion then protonotion.

protonotion then metanotion:
	protonotion;
	protonotion, metanotion then protonotion;
	protonotion, space plus, (protonotion or metanotion) plus.

metanotion then protonotion:
	metanotion;
	metanotion, protonotion then metanotion;	
	metanotion, space plus, (protonotion or metanotion) plus. 
	
metanotion: large syntactic mark plus.
large syntactic mark plus:
	large syntactic mark symbol;
	large syntactic mark plus, large syntactic mark symbol.

protonotion: small syntactic mark plus.
small syntactic mark plus:
	small syntactic mark symbol;
	small syntactic mark plus, small syntactic mark symbol.
	
space plus: 
	space symbol;
	space plus, space symbol.

layout: separator plus; .
separator plus:
	separator symbol;
	separator plus, separator symbol.'
		representations: {
			('small syntactic mark symbol' -> (NCTerminal charSet: ($a to: $z) , '()<>')).
			('large syntactic mark symbol' -> (NCTerminal charSet: ($A to: $Z) , ($0 to: $9))).
			('space symbol' -> (NCTerminal character: Character space)).
			('colon symbol' -> (NCTerminal character: $:)).
			('semicolon symbol' -> (NCTerminal character: $;)).
			('comma symbol' -> (NCTerminal character: $,)).
			('dot symbol' -> (NCTerminal character: $.)).
			('separator symbol' -> (NCTerminal charSet: Character separators)).}
]

{ #category : #initialization }
JEVWParser >> initialize [
	super initialize.
	evaluator := self class vwEvaluator
]

{ #category : #parsing }
JEVWParser >> parse: aString [
	^ evaluator evaluate: aString
]
