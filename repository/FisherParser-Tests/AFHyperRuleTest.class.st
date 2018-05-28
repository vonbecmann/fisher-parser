Class {
	#name : #AFHyperRuleTest,
	#superclass : #TestCase,
	#instVars : [
		'hyperRule'
	],
	#category : #'FisherParser-Tests-Implementation'
}

{ #category : #tests }
AFHyperRuleTest >> setUp [
	hyperRule := nil
]

{ #category : #tests }
AFHyperRuleTest >> testAsString [
	hyperRule := 
		AFHyperRule
			head: (AWHypernotion with: #'EMPTY' asNotion)
			body: {}.
	self assert: hyperRule asString equals: 'EMPTY: .'
]

{ #category : #tests }
AFHyperRuleTest >> testAsString02 [
	hyperRule := 
		AFHyperRule
			head: (AWHypernotion withAll: {(#'NOTION' asNotion). ('option' asNotion)})
			body: {(AWHypernotion with: (#'NOTION' asNotion))}.
	self 
		assert: hyperRule asString 
		equals: 'NOTION option: NOTION.'
]

{ #category : #tests }
AFHyperRuleTest >> testEqual [
	| one another |
	one := AFHyperRule head: (AWHypernotion with: (#'EMPTY' asNotion)) body: {}.
	another := AFHyperRule head: (AWHypernotion with: (#'EMPTY' asNotion)) body: {}.

	self deny: one == another.
	self assert: one equals: another.
	self assert: one hash equals: another hash
]

{ #category : #tests }
AFHyperRuleTest >> testEqual02 [
	| one another |
	one := AFHyperRule head: (AWHypernotion with: (#'EMPTY' asNotion)) body: {}.
	another := one.

	self assert: one == another.
	self assert: one equals: another.
	self assert: one hash equals: another hash
]

{ #category : #tests }
AFHyperRuleTest >> testEqual03 [
	| one another |
	one := 
	AFHyperRule
		head: 	(AWHypernotion withAll: {(#'NOTION' asNotion). ('option' asNotion)})
		body: {(AWHypernotion with: (#'NOTION' asNotion))}.
	another := 
	AFHyperRule
		head: 	(AWHypernotion withAll: {(#'NOTION' asNotion). ('option' asNotion)})
		body: {(AWHypernotion with: (#'NOTION' asNotion))}.
	self deny: one == another.
	self assert: one equals: another.
	self assert: one hash equals: another hash.
	
]

{ #category : #tests }
AFHyperRuleTest >> testIsEpsilon [
	hyperRule := AFHyperRule head: (AWHypernotion with: 'letter' asNotion) body: {}.
	self assert: hyperRule isEpsilon
]

{ #category : #tests }
AFHyperRuleTest >> testIsRepresentation [
	hyperRule := 
		AFHyperRule 
			head: (AWHypernotion with: 'letter' asNotion) 
			body: {(NCTerminal character: $a) asNotion}.
			
	self assert: hyperRule isRepresentation
]

{ #category : #tests }
AFHyperRuleTest >> testIsRepresentation02 [
	hyperRule := 
		AFHyperRule 
			head: (AWHypernotion with: 'letter' asNotion) 
			body: {(AWHypernotion with: 'a' asNotion)}.
	self deny: hyperRule isRepresentation
]

{ #category : #tests }
AFHyperRuleTest >> testIsRepresentation03 [
	hyperRule := AFHyperRule
		head: 	(AWHypernotion withAll: {#'NOTION' asNotion. 'option' asNotion})
		body: {(AWHypernotion with: #'NOTION' asNotion)}.
	self deny: hyperRule isRepresentation
]

{ #category : #tests }
AFHyperRuleTest >> testIsRepresentation04 [
	hyperRule := AFHyperRule
		head: 	(AWHypernotion withAll: {#'NOTION' asNotion. 'option' asNotion})
		body: {}.
	self deny: hyperRule isRepresentation
]

{ #category : #tests }
AFHyperRuleTest >> testIsRepresentation05 [
	hyperRule := AFHyperRule
		head: (AWHypernotion with: #LETTER asNotion)
		body: {(NCTerminal character: $a) asNotion}.
	self deny: hyperRule isRepresentation
]
