Extension { #name : #AWHyperRule }

{ #category : #'*FisherParser-Core' }
AWHyperRule >> dotAtBeginning [
	^ AFDottedHyperRule atTheBeginningOf: self
]

{ #category : #'*FisherParser-Core' }
AWHyperRule >> dotAtEnd [
	^ AFDottedHyperRule atTheEndOf: self
]
