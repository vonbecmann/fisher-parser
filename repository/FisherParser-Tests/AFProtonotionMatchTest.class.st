"
a protonotion matcher.

"
Class {
	#name : #AFProtonotionMatchTest,
	#superclass : #AFMatchTest,
	#category : #'FisherParser-Tests-Matching'
}

{ #category : #tests }
AFProtonotionMatchTest >> testMatch [
	| protonotion substitution |
	protonotion := 
		AFHypernotion
			belongsTo: self examples test3 metaGrammar
			withAll: #('h' 'symbol') asNotions.

	substitution := protonotion match: (AFHypernotion with: (AWProtonotion with: 'hsymbol')).

	self assert: substitution isSolution.
	self assert: substitution isEmpty
]

{ #category : #tests }
AFProtonotionMatchTest >> testMatch02 [
	| protonotion substitution |
	protonotion := 
		AFHypernotion
			belongsTo: self examples test3 metaGrammar
			withAll: #('h' 'symbol') asNotions.

	substitution := protonotion match: (AFHypernotion with: (AWProtonotion with: 'program')).

	self deny: substitution isSolution.

]

{ #category : #tests }
AFProtonotionMatchTest >> testMatch03 [
	| protonotion substitution |
	protonotion := 
		AFHypernotion
			belongsTo: self examples test3 metaGrammar
			withAll: #('h' 'symbol') asNotions.

	substitution := 
		protonotion match: (AFHypernotion withAll: #('h' 'symbol') asNotions).

	self assert: substitution isSolution.
	self assert: substitution isEmpty
]
