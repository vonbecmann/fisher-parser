Extension { #name : #AWProtonotion }

{ #category : #'*FisherParser-Core' }
AWProtonotion >> apply: aSubstitution [ 
	^ self
]

{ #category : #'*FisherParser-Core' }
AWProtonotion >> buildBodyOf: symbols [
	^ Array
		streamContents: [ :s | 
			| orthoNonterminal |
			smallSyntacticMarks
				do: [ :letter | 
					orthoNonterminal := NCNonterminal named: letter.
					s nextPut: (symbols detect: [ :symbol | symbol = orthoNonterminal ]) ] ]
]
