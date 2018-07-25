"
Fisher's Parser
"
Class {
	#name : #AFParser,
	#superclass : #AFYoYoAlgorithm,
	#category : #'FisherParser-Core-Implementation'
}

{ #category : #private }
AFParser >> complete: item [
	" complete with parsing "

	item
		predictionItemsDo: [ :previous | 
			(previous symbolAtDot match: item head)
				ifSolution: [ :substitution | 
					(item end add: (previous moveDotForwardAfterApplying: substitution))
						addFamilyWith: previous and: item ] ]
]

{ #category : #private }
AFParser >> gapScan: item [
	" gap scanner with parsing "

	(item symbolAtDot match: emptyHypernotion)
		ifSolution: [ :substitution | 
			(item end add: (item moveDotForwardAfterApplying: substitution))
				addFamily: (AFFamily with: item node) ]
]

{ #category : #private }
AFParser >> newParseForestWith: item [
	self
		assert: [ item familiesSize = 1 ];
		assert: [ item families first size = 1 ].
	^ AFParseForest with: (AFBSPPForest root: item families first first)
]

{ #category : #parsing }
AFParser >> parse: aString [
	| chart finalItem |
	chart := self evaluate: aString.
	finalItem := grammar startHyperRule dotAtEnd startAt: chart first.
	^ (chart last includes: finalItem)
		ifTrue: [ self newParseForestWith: (chart last like: finalItem) ]
		ifFalse: [ AFFailure signal ]
]
