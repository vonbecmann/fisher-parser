Extension { #name : #AWMetaProductionRule }

{ #category : #'*FisherParser-Core' }
AWMetaProductionRule >> asProductionRule [
	^ NCProductionRule 
			head: head asNonterminal 
			body: body asArrayOfSymbols
]
