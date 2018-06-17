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
	hyperRule := AFHyperRule headWith: #'EMPTY' asNotion body: {}.

	self assert: hyperRule asString equals: 'EMPTY: .'
]

{ #category : #tests }
AFHyperRuleTest >> testAsString02 [
	hyperRule := 
		AFHyperRule
			headWithAll: #(#'NOTION' 'option') asNotions
			body: {(AFHypernotion with: #'NOTION' asNotion)}.
	self 
		assert: hyperRule asString 
		equals: 'NOTION option: NOTION.'
]

{ #category : #tests }
AFHyperRuleTest >> testEqual [
	| one another |
	one := AFHyperRule headWith: (#'EMPTY' asNotion) body: {}.
	another := AFHyperRule headWith: (#'EMPTY' asNotion) body: {}.

	self deny: one == another.
	self assert: one equals: another.
	self assert: one hash equals: another hash
]

{ #category : #tests }
AFHyperRuleTest >> testEqual02 [
	| one another |
	one := AFHyperRule headWith: (#'EMPTY' asNotion) body: {}.
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
		headWithAll: #(#'NOTION' 'option') asNotions
		body: {(AFHypernotion with: (#'NOTION' asNotion))}.
	another := 
	AFHyperRule
		headWithAll: #(#'NOTION' 'option') asNotions
		body: {(AFHypernotion with: (#'NOTION' asNotion))}.

	self deny: one == another.
	self assert: one equals: another.
	self assert: one hash equals: another hash.
	
]

{ #category : #tests }
AFHyperRuleTest >> testIsEpsilon [
	hyperRule := AFHyperRule headWith: 'letter' asNotion body: {}.
	
	self assert: hyperRule isEpsilon
]

{ #category : #'tests - boundness' }
AFHyperRuleTest >> testIsLeftBound [
	hyperRule := 
		AFHyperRule
			headWithAll: #('i' #LETTER 's') asNotions
			body: {(AFHypernotion withAll: #('i' #LETTER 's') asNotions)}.
			
	self assert: hyperRule isLeftBound
]

{ #category : #'tests - boundness' }
AFHyperRuleTest >> testIsLeftBound02 [
	hyperRule := 
		AFHyperRule
			headWithAll: #(#TALLY #LETTER 's') asNotions
			body: {(AFHypernotion withAll: #('i' #LETTER 's') asNotions)}.
			
	self deny: hyperRule isLeftBound
]

{ #category : #tests }
AFHyperRuleTest >> testIsRepresentation [
	hyperRule := 
		AFHyperRule 	
			headWith: 'letter' asNotion 
			body: {AFHypernotion with: (NCTerminal character: $a)}.
			
	self assert: hyperRule isRepresentation
]

{ #category : #tests }
AFHyperRuleTest >> testIsRepresentation02 [
	hyperRule := 
		AFHyperRule 
			headWith: 'letter' asNotion 
			body: {(AFHypernotion with: 'a' asNotion)}.
	self deny: hyperRule isRepresentation
]

{ #category : #tests }
AFHyperRuleTest >> testIsRepresentation03 [
	hyperRule := AFHyperRule
		headWithAll: #(#'NOTION' 'option') asNotions
		body: {(AFHypernotion with: #'NOTION' asNotion)}.
	self deny: hyperRule isRepresentation
]

{ #category : #tests }
AFHyperRuleTest >> testIsRepresentation04 [
	hyperRule := AFHyperRule
		headWithAll: #(#'NOTION' 'option') asNotions
		body: {}.
	self deny: hyperRule isRepresentation
]

{ #category : #tests }
AFHyperRuleTest >> testIsRepresentation05 [
	hyperRule := AFHyperRule
		headWith: #LETTER asNotion
		body: {(AFHypernotion with: (NCTerminal character: $a))}.
		
	self deny: hyperRule isRepresentation
]

{ #category : #'tests - boundness' }
AFHyperRuleTest >> testIsRightBound [
	hyperRule := 
		AFHyperRule
			headWithAll: #('i' #LETTER 's') asNotions
			body: {(AFHypernotion withAll: #('i' #LETTER 's') asNotions)}.

	self assert: hyperRule isRightBound
]

{ #category : #'tests - boundness' }
AFHyperRuleTest >> testIsRightBound02 [
	hyperRule := 
		AFHyperRule
			headWithAll: #('i' #LETTER 's') asNotions
			body:
				{(AFHypernotion withAll: #('i' #LETTER 's') asNotions).
				(AFHypernotion with: (AWMetanotion named: 'TALLY'))}.

	self deny: hyperRule isRightBound
]
