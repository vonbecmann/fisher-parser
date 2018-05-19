Extension { #name : #NCTerminal }

{ #category : #'*AWijngaarden-Core' }
NCTerminal >> asNotion [
	^ AWHypernotion with: self
]

{ #category : #'*AWijngaarden-Core' }
NCTerminal >> isMetanotion [
	^ false
]

{ #category : #'*AWijngaarden-Core' }
NCTerminal >> isProtonotion [
	^ false
]
