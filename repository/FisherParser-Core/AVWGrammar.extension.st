Extension { #name : #AVWGrammar }

{ #category : #'*FisherParser-Core' }
AVWGrammar >> accepts: aString [
	^ (AFRecognizer given: self) accepts: aString
]
