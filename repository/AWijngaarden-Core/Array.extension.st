Extension { #name : #Array }

{ #category : #'*AWijngaarden-Core' }
Array >> asNotion [
	^ AWHypernotion withAll: self asNotions
]

{ #category : #'*AWijngaarden-Core' }
Array >> asNotions [
	^ self collect: [ :each | each asNotion ]
]
