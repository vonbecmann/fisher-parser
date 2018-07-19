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
			bodyWith: (AFHypernotion with: #'NOTION' asNotion).
	self 
		assert: hyperRule asString 
		equals: 'NOTIONoption: NOTION.'
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
		bodyWith: (AFHypernotion with: (#'NOTION' asNotion)).
	another := 
	AFHyperRule
		headWithAll: #(#'NOTION' 'option') asNotions
		bodyWith: (AFHypernotion with: (#'NOTION' asNotion)).

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
AFHyperRuleTest >> testIsLRType [
	hyperRule := 
		AFHyperRule
			headWithAll: #('i' #LETTER 's') asNotions
			bodyWith: (AFHypernotion withAll: #(#LETTER 'symbol') asNotions).
			
	self assert: hyperRule isLRType.
	self assert: hyperRule isLeftBound.
	self assert: hyperRule isRightBound
]

{ #category : #'tests - boundness' }
AFHyperRuleTest >> testIsLType [
	"TAGS statement sequence:
	   TAGS statement sequence, TAG applied occurrence, where TAG is in TAGS."
	
	hyperRule := 
		AFHyperRule
			headWithAll: #(TAGS 'statement' 'sequence') asNotions
			body: 
				{(AFHypernotion withAll: #(TAGS 'statement' 'sequence') asNotions).
				(AFHypernotion withAll: #(TAG 'applied' 'occurrence') asNotions).
				(AFHypernotion withAll: #('where' TAG 'is' 'in' TAGS) asNotions)}.
			
	self assert: hyperRule isLType.
	self assert: hyperRule isLeftBound.
	self deny: hyperRule isRightBound 
]

{ #category : #'tests - boundness' }
AFHyperRuleTest >> testIsLeftBound [
	hyperRule := 
		AFHyperRule
			headWithAll: #('i' #LETTER 's') asNotions
			bodyWith: (AFHypernotion withAll: #('i' #LETTER 's') asNotions).
			
	self assert: hyperRule isLeftBound
]

{ #category : #'tests - boundness' }
AFHyperRuleTest >> testIsLeftBound02 [
	hyperRule := 
		AFHyperRule
			headWithAll: #(#TALLY #LETTER 's') asNotions
			bodyWith: (AFHypernotion withAll: #('i' #LETTER 's') asNotions).
			
	self deny: hyperRule isLeftBound
]

{ #category : #'tests - boundness' }
AFHyperRuleTest >> testIsLeftBound03 [
	hyperRule := 
		AFHyperRule
			headWithAll: #('a' 's') asNotions
			bodyWith: (AFHypernotion withAll: #('letter' 'a' 'symbol') asNotions).
			
	self deny: hyperRule isLeftBound
]

{ #category : #'tests - boundness' }
AFHyperRuleTest >> testIsLeftBound04 [
	hyperRule := 
		AFHyperRule
			headWithAll: #('letter' 'a' 'symbol') asNotions
			bodyWith: (AFHypernotion with: (NCTerminal character: $a)).
		
	self deny: hyperRule isLeftBound
]

{ #category : #'tests - boundness' }
AFHyperRuleTest >> testIsLeftBoundIffForAll [
	hyperRule := AFHyperRule
		headWithAll: #('i' #LETTER 's') asNotions
		bodyWith: (AFHypernotion withAll: #('i' #LETTER 's') asNotions).

	self 
		assert: (hyperRule isLeftBoundIffForAll: {(AWMetanotion named: #LETTER)})
]

{ #category : #'tests - boundness' }
AFHyperRuleTest >> testIsLeftBoundIffForAll02 [
	hyperRule := AFHyperRule
		headWithAll: #(#TALLY #LETTER 's') asNotions
		bodyWith: (AFHypernotion withAll: #('i' #LETTER 's') asNotions).

	self
		deny:
			(hyperRule
				isLeftBoundIffForAll:
					{(AWMetanotion named: #TALLY).
					(AWMetanotion named: #LETTER)})
]

{ #category : #'tests - boundness' }
AFHyperRuleTest >> testIsLeftBoundIffForAll03 [
	hyperRule := 
		AFHyperRule
			headWithAll: #('a' 's') asNotions
			bodyWith: (AFHypernotion withAll: #('letter' 'a' 'symbol') asNotions).
			
	self assert: (hyperRule isLeftBoundIffForAll: #())
	
]

{ #category : #'tests - boundness' }
AFHyperRuleTest >> testIsLeftBoundIffForAll04 [
	hyperRule := 
	AFHyperRule
		headWithAll: #('letter' 'a' 'symbol') asNotions
		bodyWith: (AFHypernotion with: (NCTerminal character: $a)).
	
	self assert: (hyperRule isLeftBoundIffForAll: #())
]

{ #category : #'tests - boundness' }
AFHyperRuleTest >> testIsRType [
	"where TAG1 is in TAG2 TAGS: 	where TAG1 is in TAGS."
	hyperRule := 
		AFHyperRule
			headWithAll: #('where' TAG1 'is' 'in' TAG2 TAGS) asNotions
			bodyWith: (AFHypernotion withAll: #('where' TAG1 'is' 'in' TAGS) asNotions).
			
	self assert: hyperRule isRType.
	self assert: hyperRule isRightBound.
	self deny: hyperRule isLeftBound 
]

{ #category : #tests }
AFHyperRuleTest >> testIsRepresentation [
	hyperRule := 
		AFHyperRule 	
			headWith: 'letter' asNotion 
			bodyWith: (AFHypernotion with: (NCTerminal character: $a)).
			
	self assert: hyperRule isRepresentation
]

{ #category : #tests }
AFHyperRuleTest >> testIsRepresentation02 [
	hyperRule := 
		AFHyperRule 
			headWith: 'letter' asNotion 
			bodyWith: (AFHypernotion with: 'a' asNotion).
	self deny: hyperRule isRepresentation
]

{ #category : #tests }
AFHyperRuleTest >> testIsRepresentation03 [
	hyperRule := AFHyperRule
		headWithAll: #(#'NOTION' 'option') asNotions
		bodyWith: (AFHypernotion with: #'NOTION' asNotion).
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
		bodyWith: (AFHypernotion with: (NCTerminal character: $a)).
		
	self deny: hyperRule isRepresentation
]

{ #category : #'tests - boundness' }
AFHyperRuleTest >> testIsRightBound [
	hyperRule := 
		AFHyperRule
			headWithAll: #('i' #LETTER 's') asNotions
			bodyWith: (AFHypernotion withAll: #('i' #LETTER 's') asNotions).

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

{ #category : #'tests - boundness' }
AFHyperRuleTest >> testIsRightBound03 [
	hyperRule := 
		AFHyperRule
			headWithAll: #('a' 's') asNotions
			bodyWith: (AFHypernotion withAll: #('letter' 'a' 'symbol') asNotions).
			
	self deny: hyperRule isRightBound
]

{ #category : #'tests - boundness' }
AFHyperRuleTest >> testIsRightBound04 [
	hyperRule := 
		AFHyperRule
			headWithAll: #('letter' 'a' 'symbol') asNotions
			bodyWith: (AFHypernotion with: (NCTerminal character: $a)).
			
	self deny: hyperRule isRightBound
]

{ #category : #'tests - boundness' }
AFHyperRuleTest >> testIsRightBoundIffForAll [
	hyperRule := AFHyperRule
		headWithAll: #('i' #LETTER 's') asNotions
		bodyWith: (AFHypernotion withAll: #('i' #LETTER 's') asNotions).

	self 
		assert: (hyperRule isRightBoundIffForAll: {(AWMetanotion named: #LETTER)})
]

{ #category : #'tests - boundness' }
AFHyperRuleTest >> testIsRightBoundIffForAll02 [
	hyperRule := 
	AFHyperRule
		headWithAll: #('i' #LETTER 's') asNotions
		body:
			{(AFHypernotion withAll: #('i' #LETTER 's') asNotions).
			(AFHypernotion with: (AWMetanotion named: 'TALLY'))}.
	self
		deny:
			(hyperRule
				isRightBoundIffForAll:
					{(AWMetanotion named: #LETTER).
					(AWMetanotion named: #TALLY)})
]

{ #category : #'tests - boundness' }
AFHyperRuleTest >> testIsRightBoundIffForAll03 [
	hyperRule := 
	AFHyperRule
		headWithAll: #('a' 's') asNotions
		bodyWith: (AFHypernotion withAll: #('letter' 'a' 'symbol') asNotions).
	
	self assert: (hyperRule isRightBoundIffForAll: #())
]

{ #category : #'tests - boundness' }
AFHyperRuleTest >> testIsRightBoundIffForAll04 [
	hyperRule := 
	AFHyperRule
		headWithAll: #('letter' 'a' 'symbol') asNotions
		bodyWith: (AFHypernotion with: (NCTerminal character: $a)).
		
	self assert: (hyperRule isRightBoundIffForAll: #())
]

{ #category : #'tests - strict language' }
AFHyperRuleTest >> testIsStrict [
	hyperRule := 
		AFHyperRule
			headWithAll: #('letter' 'a' 'symbol') asNotions
			bodyWith: (AFHypernotion with: (NCTerminal character: $a)).
			
	self assert: hyperRule isStrict
]

{ #category : #'tests - strict language' }
AFHyperRuleTest >> testIsStrict02 [
	hyperRule := 
		AFHyperRule
			headWithAll: #('letter' 'a') asNotions
			bodyWith: (AFHypernotion withAll: #('letter' 'a' 'symbol') asNotions).
			
	self assert: hyperRule isStrict
]

{ #category : #'tests - boundness' }
AFHyperRuleTest >> testIsXType [
	hyperRule := 
		AFHyperRule
			headWithAll: #('where' '<' NOTION '>' 'is' '<' NOTION '>') asNotions
			bodyWith: (AFHypernotion with: #EMPTY asNotion).
			
	self assert: hyperRule isXType.
	self deny: hyperRule isLeftBound.
	self deny: hyperRule isRightBound
]
