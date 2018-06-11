Class {
	#name : #AFHypernotionMatcherTest,
	#superclass : #TestCase,
	#category : #'FisherParser-Tests-MetaMatching'
}

{ #category : #tests }
AFHypernotionMatcherTest >> testMatch [
	| hypernotion substitution |
	hypernotion := AFHypernotion
		belongsTo: AFExemplar test3
		withAll: #('where' '<' #NOTION '>' 'is' '<' #NOTION '>') asNotions.

	substitution := hypernotion match: (AFHypernotion with: 'where<h>is<i>' asNotion).

	self deny: substitution isSolution
]

{ #category : #tests }
AFHypernotionMatcherTest >> testMatch02 [
	| hypernotion substitution |
	hypernotion := AFHypernotion
		belongsTo: AFExemplar test3
		withAll: #('where' '<' #NOTION '>' 'is' '<' #NOTION '>') asNotions.

	substitution := hypernotion match: (AFHypernotion with: 'where<hij>is<hij>' asNotion).

	self assert: substitution isSolution.
	self
		assert: (substitution at: #NOTION asNotion)
		equals: 'hij' asNotion
]

{ #category : #tests }
AFHypernotionMatcherTest >> testMatch03 [
	| hypernotion substitution |
	hypernotion := AFHypernotion
		belongsTo: AFExemplar test3
		withAll: #('where' '<' #NOTION '>' 'is' '<' #NOTION '>') asNotions.
	
	substitution := hypernotion match: (AFHypernotion with: 'where<j>is<h>' asNotion).
	
	self deny: substitution isSolution
]

{ #category : #tests }
AFHypernotionMatcherTest >> testMatch04 [
	| hypernotion substitution |
	hypernotion := AFHypernotion
		belongsTo: AFExemplar test3
		withAll: #('where' '<' #NOTION '>' 'is' '<' #NOTION '>') asNotions.

	substitution := hypernotion match: (AFHypernotion with: 'where<j>is<j>' asNotion).
		
	self assert: substitution isSolution.
	self 
		assert: (substitution at: #NOTION asNotion)
		equals: 'j' asNotion
]
