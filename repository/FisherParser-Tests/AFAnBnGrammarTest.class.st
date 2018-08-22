"
an bn grammar
"
Class {
	#name : #AFAnBnGrammarTest,
	#superclass : #AFGrammarTest,
	#category : #'FisherParser-Tests-Grammar'
}

{ #category : #running }
AFAnBnGrammarTest >> setUp [
	super setUp.
	grammar := self examples anbn
]

{ #category : #tests }
AFAnBnGrammarTest >> testAcceptsA2B2 [
	self assert: (grammar accepts: 'aabb')
]

{ #category : #tests }
AFAnBnGrammarTest >> testAcceptsA3B3 [
	self assert: (grammar accepts: 'aaabbb')
]

{ #category : #tests }
AFAnBnGrammarTest >> testAcceptsAB [
	self assert: (grammar accepts: 'ab')
]

{ #category : #tests }
AFAnBnGrammarTest >> testAcceptsAC [
	self deny: (grammar accepts: 'ac')
]

{ #category : #tests }
AFAnBnGrammarTest >> testAcceptsBC [
	self deny: (grammar accepts: 'bc')
]

{ #category : #tests }
AFAnBnGrammarTest >> testAcceptsEpsilon [
	self deny: (grammar accepts: '')
]

{ #category : #tests }
AFAnBnGrammarTest >> testAnalyzeAcceptsAB [
	| analysis chart |
	analysis := grammar analyzeAccepts: 'ab'.
	self assert: (analysis at: 'accepts').
	chart := analysis at: 'chart'.
	self assert: chart size equals: 3
]

{ #category : #tests }
AFAnBnGrammarTest >> testAnalyzeAcceptsAC [
	| analysis exception |
	analysis := grammar analyzeAccepts: 'ac'.
	self deny: (analysis at: 'accepts').
	exception := analysis at: 'exception'.
	self assert: exception asString equals: 'AFFailure: failed at AFColumn(2)'
]
