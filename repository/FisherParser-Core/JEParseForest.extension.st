Extension { #name : 'JEParseForest' }

{ #category : '*FisherParser-Core' }
JEParseForest >> substitutionsOf: metanotions [
	^ syntaxForest substitutionsOf: metanotions
]
