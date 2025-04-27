Extension { #name : 'AWHypernotion' }

{ #category : '*FisherParser-Core' }
AWHypernotion >> buildBodyOf: symbols [
	^ Array
		streamContents: [ :s | 
			notions
				do: [ :each | 
					each isMetanotion
						ifTrue: [ s nextPut: (symbols detect: [ :symbol | symbol = each ]) ].
					each isProtonotion
						ifTrue: [ s nextPutAll: (each buildBodyOf: symbols) ].
					each isTerminal
						ifTrue: [ s nextPut: (symbols detect: [ :symbol | symbol = each ]) ] ] ]
]
