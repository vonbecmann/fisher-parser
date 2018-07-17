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
		'grammar',
		'emptyHypernotion'
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
			(hrule body first match: item head)
				ifSolution: [ :substitution | 
					item start addDottedHyperRule: (hrule apply: substitution) dotAtBeginning ] ]
]

{ #category : #private }
AFYoYoAlgorithm >> complete: item [
	item predictionItemsDo: [ :previous | 
			(previous symbolAtDot match: item head) 
				ifSolution: [ :substitution | 
					item end add: (previous moveDotForwardAfterApplying: substitution) ] ]
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
										ifTrue: [ (chart at: i + 1) add: item moveDotForward ].
							item symbolAtDot isProtonotion
								ifTrue: [ self topDownPredict: item ].
							item symbolAtDot isHypernotion
								ifTrue: [ self gapScan: item ] ] ] ].
	^ chart
]

{ #category : #private }
AFYoYoAlgorithm >> gapScan: item [
	" gap scanner "

	(item symbolAtDot match: emptyHypernotion)
		ifSolution: [ :substitution | 
			item end add: (item moveDotForwardAfterApplying: substitution) ]
]

{ #category : #initialization }
AFYoYoAlgorithm >> initialize [
	super initialize.
	emptyHypernotion := AFHypernotion empty
]

{ #category : #initialization }
AFYoYoAlgorithm >> initializeGrammar: aVWGrammar [
	self initialize.
	grammar := aVWGrammar
]

{ #category : #private }
AFYoYoAlgorithm >> topDownPredict: item [
	item symbolAtDot
		forwardCrossReferencesDo: [ :hrule | 
			(hrule head match: item symbolAtDot)
				ifSolution: [ :substitution | 
					item end addDottedHyperRule: (hrule apply: substitution) dotAtBeginning ] ]
]
