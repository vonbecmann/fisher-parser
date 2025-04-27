Extension { #name : 'SinglyLinkedList' }

{ #category : '*FisherParser-Core' }
SinglyLinkedList >> product: metanotionSubstitutionCollection [
	^ self isEmpty
		ifTrue: [ metanotionSubstitutionCollection ]
		ifFalse: [ | product |
			product := self class new.
			self do: [ :metanotionSubstitution | product addAll: (metanotionSubstitution product: metanotionSubstitutionCollection) ].
			product ]
]
