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
AWHypernotion >> asNonterminal [
	^ NCNonterminal named: self printString
]

{ #category : #'*FisherParser-Core' }
AWHypernotion >> asStrictString [
	^ String streamContents: [ :s | notions do: [ :each | each printOn: s ] ]
]

{ #category : #'*FisherParser-Core' }
AWHypernotion >> matches: aCharacter [ 
	^ notions first matches: aCharacter 
]

{ #category : #'*FisherParser-Core' }
AWHypernotion >> substituteMetanotionsBy: anAssocCollection [
	^ AWHypernotion
		withAll:
			(notions
				collect: [ :notion | 
					(notion isMetanotion and: [ anAssocCollection includesMetanotion: notion ])
						ifTrue: [ anAssocCollection at: notion ]
						ifFalse: [ notion ] ])
]
