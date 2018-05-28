Extension { #name : #ESTree }

{ #category : #'*FisherParser-Core' }
ESTree >> nodeOf: aHypernotion [
	self assert: root model symbol named = aHypernotion asString asSymbol.
	^ root
]
