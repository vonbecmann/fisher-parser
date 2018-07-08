Extension { #name : #AWHypernotion }

{ #category : #'*FisherParser-Core' }
AWHypernotion >> buildBodyOf: symbols [
	^ Array
		streamContents: [ :s | 
			notions
				do: [ :each | 
					each isMetanotion
						ifTrue: [ s nextPut: (symbols like: each ifAbsent: [ Error signal ]) ].
					each isProtonotion
						ifTrue: [ each do: [ :char | s nextPut: (symbols like: (NCNonterminal named: char) ifAbsent: [ Error signal ]) ] ].
					each isTerminal
						ifTrue: [ s nextPut: (symbols like: each ifAbsent: [ Error signal ]) ] ] ]
]
