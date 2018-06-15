Class {
	#name : #AFHypernotionMatcherTest,
	#superclass : #TestCase,
	#category : #'FisherParser-Tests-MetaMatching'
}

{ #category : #tests }
AFHypernotionMatcherTest >> testMatch [
	| hypernotion substitution |
	hypernotion := 
		AFHypernotion
			belongsTo: AFExemplar test3
			withAll: #('where' '<' #NOTION '>' 'is' '<' #NOTION '>') asNotions.

	substitution := hypernotion match: (AFHypernotion with: (AWProtonotion with: 'where<h>is<i>')).

	self deny: substitution isSolution
]

{ #category : #tests }
AFHypernotionMatcherTest >> testMatch02 [
	| hypernotion substitution |
	hypernotion := 
		AFHypernotion
			belongsTo: AFExemplar test3
			withAll: #('where' '<' #NOTION '>' 'is' '<' #NOTION '>') asNotions.

	substitution := hypernotion match: (AFHypernotion with: (AWProtonotion with: 'where<hij>is<hij>')).

	self assert: substitution isSolution.
	self
		assert: (#NOTION asNotion apply: substitution) 
		equals: 'hij' asNotion
]

{ #category : #tests }
AFHypernotionMatcherTest >> testMatch03 [
	| hypernotion substitution |
	hypernotion := 
		AFHypernotion
			belongsTo: AFExemplar test3
			withAll: #('where' '<' #NOTION '>' 'is' '<' #NOTION '>') asNotions.
	
	substitution := hypernotion match: (AFHypernotion with: (AWProtonotion with: 'where<j>is<h>')).
	
	self deny: substitution isSolution
]

{ #category : #tests }
AFHypernotionMatcherTest >> testMatch04 [
	| hypernotion substitution |
	hypernotion := 
		AFHypernotion
			belongsTo: AFExemplar test3
			withAll: #('where' '<' #NOTION '>' 'is' '<' #NOTION '>') asNotions.

	substitution := hypernotion match: (AFHypernotion with: (AWProtonotion with: 'where<j>is<j>')).
		
	self assert: substitution isSolution.
	self 
		assert: (#NOTION asNotion apply: substitution)
		equals: 'j' asNotion
]
