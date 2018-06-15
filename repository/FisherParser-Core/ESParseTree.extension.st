Extension { #name : #ESParseTree }

{ #category : #'*FisherParser-Core' }
ESParseTree >> substitutionsOf: anAFHypernotion [
	^ tree substitutionsOf: anAFHypernotion metanotions
]
