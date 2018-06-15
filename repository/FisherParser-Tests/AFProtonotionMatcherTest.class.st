"
a protonotion matcher.

"
Class {
	#name : #AFProtonotionMatcherTest,
	#superclass : #TestCase,
	#category : #'FisherParser-Tests-MetaMatching'
}

{ #category : #tests }
AFProtonotionMatcherTest >> testMatch [
	| protonotion substitution |
	protonotion := 
		AFHypernotion
			belongsTo: AFExemplar test3
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
			belongsTo: AFExemplar test3
			withAll: #('h' 'symbol') asNotions.

	substitution := protonotion match: (AFHypernotion with: (AWProtonotion with: 'program')).

	self deny: substitution isSolution.

]

{ #category : #tests }
AFProtonotionMatcherTest >> testMatch03 [
	| protonotion substitution |
	protonotion := 
		AFHypernotion
			belongsTo: AFExemplar test3
			withAll: #('h' 'symbol') asNotions.

	substitution := 
		protonotion match: (AFHypernotion withAll: #('h' 'symbol') asNotions).

	self assert: substitution isSolution.
	self assert: substitution isEmpty
]
