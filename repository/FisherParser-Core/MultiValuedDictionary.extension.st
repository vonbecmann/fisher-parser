Extension { #name : 'MultiValuedDictionary' }

{ #category : '*FisherParser-Core' }
MultiValuedDictionary >> firstOf: symbols [
	| symbolsFirst |
	symbolsFirst := collectionClass new.
	symbols isEmpty
		ifTrue: [ symbolsFirst add: #epsilon ]
		ifFalse: [ | index symbol |
			index := 0.
			[ symbol := symbols at: (index := index + 1).
			symbol isTerminal
				ifTrue: [ symbolsFirst add: symbol ]
				ifFalse: [ symbolsFirst addAll: ((self at: symbol) copyWithout: #epsilon) ] ]
				doWhileTrue: [ 
					index < symbols size 
						and: [ symbol isNonterminal and: [ (self at: symbol) includes: #epsilon ] ] ].
			(symbols
				allSatisfy: [ :eachSymbol | eachSymbol isNonterminal and: [ (self at: eachSymbol) includes: #epsilon ] ])
				ifTrue: [ symbolsFirst add: #epsilon ] ].
	^ symbolsFirst
]
