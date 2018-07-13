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
	grammar representationRules
		do: [ :dottedHyperRule | 
			(dottedHyperRule symbolAtDot matches: word)
				ifTrue: [ column add: (dottedHyperRule startAt: column) ] ]
]

{ #category : #private }
AFYoYoAlgorithm >> bottomUpPredict: item at: aColumn [
	item head backwardCrossReferences
		do: [ :hrule | 
			(hrule body first match: item head)
				ifSolution: [ :substitution | 
					aColumn add: ((hrule apply: substitution) dotAtBeginning startAt: aColumn) ] ]
]

{ #category : #private }
AFYoYoAlgorithm >> complete: item [
	item predictionItems
		do: [ :previous | 
			(previous symbolAtDot match: item head) 
				ifSolution: [ :substitution | 
					item end add: (previous moveDotForwardAfterApplying: substitution) ] ]
]

{ #category : #private }
AFYoYoAlgorithm >> evaluate: words [
	| chart n |
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
								ifTrue: 
									 [ self bottomUpPredict: item at: item start.
									 	self complete: item ] ]
						ifFalse: [ 
							item symbolAtDot isTerminal
								ifTrue: [ 
									(i < n and: [ item symbolAtDot matches: (words at: i) ])
										ifTrue: [ (chart at: i + 1) add: item moveDotForward ] ].
							item symbolAtDot isProtonotion
								ifTrue: [ self topDownPredict: item at: column ].
							item symbolAtDot isHypernotion 
								ifTrue: [ self gapScan: item at: column ] ] ] ].
	^ chart
]

{ #category : #private }
AFYoYoAlgorithm >> gapScan: item at: column [
	" gap scanner "

	(item symbolAtDot match: emptyHypernotion)
		ifSolution: [ :substitution | 
			column add: (item moveDotForwardAfterApplying: substitution) ]
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
AFYoYoAlgorithm >> topDownPredict: item at: aColumn [
	item symbolAtDot forwardCrossReferences
		do: [ :hrule | 
			(hrule head match: item symbolAtDot)
				ifSolution: [ :substitution | 
					aColumn add: ((hrule apply: substitution) dotAtBeginning startAt: aColumn) ] ]
]
