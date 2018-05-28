Extension { #name : #AWHypernotion }

{ #category : #'*FisherParser-Core' }
AWHypernotion >> apply: aSubstitution [
	^ AWHypernotion
		withAll:
			(notions
				collect: [ :notion | 
					notion isMetanotion
						ifTrue: [ aSubstitution at: notion ]
						ifFalse: [ notion ] ])
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
