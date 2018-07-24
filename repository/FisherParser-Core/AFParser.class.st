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

{ #category : #parsing }
AFParser >> parse: aString [
	| chart finalItem |
	chart := self evaluate: aString.
	finalItem := grammar startHyperRule dotAtEnd startAt: chart first.
	^ (chart last includes: finalItem)
		ifTrue: [ chart last like: finalItem ]
		ifFalse: [ AFFailure signal ]
]
