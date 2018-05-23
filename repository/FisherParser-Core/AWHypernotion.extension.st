Extension { #name : #AWHypernotion }

{ #category : #'*FisherParser-Core' }
AWHypernotion >> asArrayOfSymbols [
	^ Array
		streamContents: [ :s | 
			notions
				do: [ :notion | 
					notion isMetanotion
						ifTrue: [ s nextPut: notion asNonterminal ].
					notion isProtonotion
						ifTrue: [ notion do: [ :char | s nextPut: (NCNonterminal named: char) ] ] ] ]
]

{ #category : #'*FisherParser-Core' }
AWHypernotion >> matches: aCharacter [ 
	^ notions first matches: aCharacter 
]
