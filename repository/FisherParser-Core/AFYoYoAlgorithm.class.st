"
Title: A ""yo-yo"" parsing algorithm for a large class of Van Wijngaarden grammars.
Author: AJ Fisher

Summary:
An algorithm is described for parsing a large class of van wijngaarden grammars in polynomial time. The algorithm is based on Earley's context-free parsing algorithm, with the addition of a bottom-up component and a mechanism for implementing consistent substitution. In contrast to earlier algorithms, this algorithm works for grammars which are both non-left-bound and non-right-bound.
"
Class {
	#name : #AFYoYoAlgorithm,
	#superclass : #Object,
	#instVars : [
		'grammar'
	],
	#category : #'FisherParser-Core-Implementation'
}

{ #category : #'instance creation' }
AFYoYoAlgorithm class >> of: aVWGrammar [
	^ self basicNew
		initializeGrammar: aVWGrammar;
		yourself
]

{ #category : #private }
AFYoYoAlgorithm >> addPreterminalsWith: word at: column [
	grammar representationRulesDo: [ :dottedHyperRule | 
			(dottedHyperRule symbolAtDot matches: word)
				ifTrue: [ column addDottedHyperRule: dottedHyperRule ] ]
]

{ #category : #private }
AFYoYoAlgorithm >> bottomUpPredict: item [
	item head
		backwardCrossReferencesDo: [ :hrule | 
			hrule body first
				match: item head
				do: [ :substitution | item start addDottedHyperRule: (hrule apply: substitution) dotAtBeginning ] ]
]

{ #category : #private }
AFYoYoAlgorithm >> complete: item [
	self subclassResponsibility
]

{ #category : #private }
AFYoYoAlgorithm >> evaluate: words [
	| n chart |
	n := words size + 1.
	chart := AFChart new: n.
	chart first add: (grammar startHyperRule dotAtBeginning startAt: chart first).
	chart
		withIndexDo: [ :column :i | 
			column isEmpty
				ifTrue: [ ^ AFFailure signal: 'failed at ' , (chart at: i - 1) asString ].
			i < n
				ifTrue: [ self addPreterminalsWith: (words at: i) at: column ].
			column
				processItems: [ :item | 
					item isFinal
						ifTrue: [ 
							item head isProtonotion
								ifTrue: [ self 
												bottomUpPredict: item;
												complete: item ] ]
						ifFalse: [ 
							(item symbolAtDot isTerminal 
								and: [ i < n and: [ item symbolAtDot matches: (words at: i) ] ])
										ifTrue: [ self scan: item with: (words at: i) at: (chart at: i + 1) ].
							item symbolAtDot isProtonotion
								ifTrue: [ self topDownPredict: item ].
							item symbolAtDot isHypernotion
								ifTrue: [ self gapScan: item ] ] ] ].
	^ chart
]

{ #category : #private }
AFYoYoAlgorithm >> gapScan: item [
	" gap scanner "

	self subclassResponsibility
]

{ #category : #initialization }
AFYoYoAlgorithm >> initializeGrammar: aVWGrammar [
	grammar := aVWGrammar
]

{ #category : #private }
AFYoYoAlgorithm >> scan: item with: word at: aColumn [
	" terminal scanner "

	self subclassResponsibility
]

{ #category : #private }
AFYoYoAlgorithm >> topDownPredict: item [
	item symbolAtDot
		forwardCrossReferencesDo: [ :hrule | 
			hrule head
				match: item symbolAtDot
				do: [ :substitution | item end addDottedHyperRule: (hrule apply: substitution) dotAtBeginning ] ]
]
