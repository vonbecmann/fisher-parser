Extension { #name : #JEParseForest }

{ #category : #'*FisherParser-Core' }
JEParseForest >> substitutionsOf: anAFHypernotion [
	^ syntaxForest substitutionsOf: anAFHypernotion metanotions
]
