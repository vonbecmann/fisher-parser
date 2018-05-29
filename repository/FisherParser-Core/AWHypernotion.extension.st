Extension { #name : #AWHypernotion }

{ #category : #'*FisherParser-Core' }
AWHypernotion >> apply: aSubstitution [
	^ self class
		withAll:
			(notions
				collect: [ :notion | 
					notion isMetanotion
						ifTrue: [ aSubstitution at: notion ]
						ifFalse: [ notion ] ])
]

{ #category : #'*FisherParser-Core' }
AWHypernotion >> asStrictString [
	^ String streamContents: [ :s | notions do: [ :each | each printOn: s ] ]
]

{ #category : #'*FisherParser-Core' }
AWHypernotion >> matches: aCharacter [ 
	^ notions first matches: aCharacter 
]
