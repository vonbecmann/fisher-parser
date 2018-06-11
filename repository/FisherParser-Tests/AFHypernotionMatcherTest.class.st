Class {
	#name : #AFHypernotionMatcherTest,
	#superclass : #TestCase,
	#category : #'FisherParser-Tests-MetaMatching'
}

{ #category : #tests }
AFHypernotionMatcherTest >> testMatch [
	| grammar hypernotion substitution |
	grammar := AFExemplar test3.
	hypernotion := AFHypernotion
		belongsTo: grammar
		withAll: #('where' '<' #NOTION '>' 'is' '<' #NOTION '>') asNotions.
	substitution := hypernotion
		match: (AFHypernotion withAll: #('where' '<' 'h' '>' 'is' '<' 'i' '>') asNotions).
	self deny: substitution isSolution
]

{ #category : #tests }
AFHypernotionMatcherTest >> testMatch02 [
	| grammar hypernotion substitution |
	grammar := AFExemplar test3.
	hypernotion := AFHypernotion
		belongsTo: grammar
		withAll: #('where' '<' #NOTION '>' 'is' '<' #NOTION '>') asNotions.
	substitution := hypernotion
		match: (AFHypernotion withAll: #('where' '<' 'hij' '>' 'is' '<' 'hij' '>') asNotions).
	
	self assert: substitution isSolution.
	self assert: (substitution at: #NOTION asNotion) equals: ('hij' asNotion)
]
