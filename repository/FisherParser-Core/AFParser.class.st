"
Fisher's Parser
"
Class {
	#name : 'AFParser',
	#superclass : 'AFYoYoAlgorithm',
	#category : 'FisherParser-Core-Implementation',
	#package : 'FisherParser-Core',
	#tag : 'Implementation'
}

{ #category : 'private' }
AFParser >> complete: item [
	" complete with parsing "

	item predictionItemsDo: [ :previous |
			previous symbolAtDot match: item head do: [ :substitution |
					previous
						addFamilyWith: item
						to:
						(item end add:
							 (previous moveDotForwardAfterApplying: substitution)) ] ]
]

{ #category : 'private' }
AFParser >> gapScan: item [
	" gap scanner with parsing "

	item symbolAtDot matchEmptyDo: [ :substitution |
			(item end add: (item moveDotForwardAfterApplying: substitution))
				addFamilyWith: item ]
]

{ #category : 'private' }
AFParser >> newParseForestWith: item [
	self
		assert: [ item familiesSize = 1 ];
		assert: [ item families first size = 1 ].
	^ AFParseForest
		given: (AFBSPPForest root: item families first first)
		of: grammar
]

{ #category : 'parsing' }
AFParser >> parse: aString [
	| chart |
	chart := self evaluate: aString.
	^ chart last
		like: (grammar startHyperRule dotAtEnd startAt: chart first)
		ifFound: [ :found | self newParseForestWith: found ]
		ifNone: [ AFFailure signal ]
]

{ #category : 'private' }
AFParser >> scan: item with: word at: aColumn [
	" terminal scanner "

	item
		addFamilyWith: (aColumn addTerminalItem:
				 (AFTerminalItem
					  given: item symbolAtDot
					  word: word
					  startedAt: item end))
		to: (aColumn add: item moveDotForward)
]
