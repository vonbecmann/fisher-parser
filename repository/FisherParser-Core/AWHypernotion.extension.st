Extension { #name : #AWHypernotion }

{ #category : #'*FisherParser-Core' }
AWHypernotion >> buildBodyOf: symbols [
	^ Array
		streamContents: [ :s | 
			notions
				do: [ :each | 
					each isMetanotion
						ifTrue: [ s nextPut: (symbols detect: [ :symbol | symbol = each ]) ].
					each isProtonotion
						ifTrue: [ | nonterminal |
							each
								do: [ :letter | 
									nonterminal := NCNonterminal named: letter.
									s nextPut: (symbols detect: [ :symbol | symbol = nonterminal ]) ] ].
					each isTerminal
						ifTrue: [ s nextPut: (symbols detect: [ :symbol | symbol = each ]) ] ] ]
]
