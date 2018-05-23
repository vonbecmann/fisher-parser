Extension { #name : #AWHyperRule }

{ #category : #'*FisherParser-Core' }
AWHyperRule >> asAFHyperRule [
	"as fisher's hyper rule"

	^ AFHyperRule head: head body: body copy
]
