Class {
	#name : #AFHypernotionMatchTest,
	#superclass : #AFMatchTest,
	#category : #'FisherParser-Tests-Matching'
}

{ #category : #tests }
AFHypernotionMatchTest >> testMatch [
	| hypernotion substitution |
	hypernotion := 
		AFHypernotion
			belongsTo: self examples test3
			withAll: #('where' '<' #NOTION '>' 'is' '<' #NOTION '>') asNotions.

	substitution := hypernotion match: (AFHypernotion with: (AWProtonotion with: 'where<h>is<i>')).

	self deny: substitution isSolution
]

{ #category : #tests }
AFHypernotionMatchTest >> testMatch02 [
	| hypernotion substitution |
	hypernotion := 
		AFHypernotion
			belongsTo: self examples test3
			withAll: #('where' '<' #NOTION '>' 'is' '<' #NOTION '>') asNotions.

	substitution := hypernotion match: (AFHypernotion with: (AWProtonotion with: 'where<hij>is<hij>')).

	self assert: substitution isSolution.
	self
		assert: (#NOTION asNotion apply: substitution) 
		equals: 'hij' asNotion
]

{ #category : #tests }
AFHypernotionMatchTest >> testMatch03 [
	| hypernotion substitution |
	hypernotion := 
		AFHypernotion
			belongsTo: self examples test3
			withAll: #('where' '<' #NOTION '>' 'is' '<' #NOTION '>') asNotions.
	
	substitution := hypernotion match: (AFHypernotion with: (AWProtonotion with: 'where<j>is<h>')).
	
	self deny: substitution isSolution
]

{ #category : #tests }
AFHypernotionMatchTest >> testMatch04 [
	| hypernotion substitution |
	hypernotion := 
		AFHypernotion
			belongsTo: self examples test3
			withAll: #('where' '<' #NOTION '>' 'is' '<' #NOTION '>') asNotions.

	substitution := hypernotion match: (AFHypernotion with: (AWProtonotion with: 'where<j>is<j>')).
		
	self assert: substitution isSolution.
	self 
		assert: (#NOTION asNotion apply: substitution)
		equals: 'j' asNotion
]
