Extension { #name : #SinglyLinkedList }

{ #category : #'*FisherParser-Core' }
SinglyLinkedList >> product: metanotionSubstitutionCollection [
	^ self isEmpty
		ifTrue: [ SinglyLinkedList withAll: metanotionSubstitutionCollection ]
		ifFalse: [ | product |
			product := SinglyLinkedList new.
			self do: [ :metanotionSubstitution | 
				product addAll: (metanotionSubstitution product: metanotionSubstitutionCollection) ].
			product ]
]
