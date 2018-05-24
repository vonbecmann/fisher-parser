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
AWHypernotion >> asProductionRule [
	^ NCProductionRule
		head: (NCNonterminal named: (String streamContents: [ :s | self printOn: s ]))
		body: self asArrayOfSymbols
]

{ #category : #'*FisherParser-Core' }
AWHypernotion >> asStrictString [
	^ String streamContents: [ :s | notions do: [ :each | each printOn: s ] ]
]

{ #category : #'*FisherParser-Core' }
AWHypernotion >> matches: aCharacter [ 
	^ notions first matches: aCharacter 
]
