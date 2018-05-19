Extension { #name : #Array }

{ #category : #'*AWijngaarden-Core' }
Array >> asNotion [
	^ AWHypernotion withAll: (self collect: [ :each | each asNotion ])
]
