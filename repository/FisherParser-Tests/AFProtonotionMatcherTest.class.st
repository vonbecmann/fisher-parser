"
a protonotion matcher.

"
Class {
	#name : #AFProtonotionMatcherTest,
	#superclass : #AFMatcherTest,
	#category : #'FisherParser-Tests-Matching'
}

{ #category : #tests }
AFProtonotionMatcherTest >> testMatch [
	| protonotion substitution |
	protonotion := 
		AFHypernotion
			belongsTo: self examples test3
			withAll: #('h' 'symbol') asNotions.

	substitution := protonotion match: (AFHypernotion with: (AWProtonotion with: 'hsymbol')).

	self assert: substitution isSolution.
	self assert: substitution isEmpty
]

{ #category : #tests }
AFProtonotionMatcherTest >> testMatch02 [
	| protonotion substitution |
	protonotion := 
		AFHypernotion
			belongsTo: self examples test3
			withAll: #('h' 'symbol') asNotions.

	substitution := protonotion match: (AFHypernotion with: (AWProtonotion with: 'program')).

	self deny: substitution isSolution.

]

{ #category : #tests }
AFProtonotionMatcherTest >> testMatch03 [
	| protonotion substitution |
	protonotion := 
		AFHypernotion
			belongsTo: self examples test3
			withAll: #('h' 'symbol') asNotions.

	substitution := 
		protonotion match: (AFHypernotion withAll: #('h' 'symbol') asNotions).

	self assert: substitution isSolution.
	self assert: substitution isEmpty
]
