"
metanotion -> substitute.

"
Class {
	#name : #AFMetanotionSubstitutions,
	#superclass : #Object,
	#instVars : [
		'associations'
	],
	#category : #'FisherParser-Core-MetaMatching'
}

{ #category : #'instance creation' }
AFMetanotionSubstitutions class >> empty [
	^ self new
]

{ #category : #'instance creation' }
AFMetanotionSubstitutions class >> with: anAssociation [
	^ self new
		add: anAssociation;
		yourself
]

{ #category : #'instance creation' }
AFMetanotionSubstitutions class >> withAll: anAssocCollection [
	^ self new
		addAll: anAssocCollection;
		yourself
]

{ #category : #adding }
AFMetanotionSubstitutions >> add: anAssociation [
	" Metanotion -> Substitute "

	(associations includes: anAssociation)
		ifFalse: [ associations addLast: anAssociation ]
]

{ #category : #adding }
AFMetanotionSubstitutions >> addAll: anAssocCollection [
	associations addAll: anAssocCollection
]

{ #category : #accessing }
AFMetanotionSubstitutions >> at: aMetanotion [
	associations
		do: [ :assoc | 
			assoc key = aMetanotion
				ifTrue: [ ^ assoc value ] ].
	^ aMetanotion
]

{ #category : #testing }
AFMetanotionSubstitutions >> includesMetanotion: aMetanotion [
	^ associations anySatisfy: [ :assoc | assoc key = aMetanotion ]
]

{ #category : #initialization }
AFMetanotionSubstitutions >> initialize [
	super initialize.
	associations := SinglyLinkedList new.
]

{ #category : #printing }
AFMetanotionSubstitutions >> printOn: aStream [
	aStream nextPut: ${.
	associations
		do: [ :assoc | aStream print: assoc ]
		separatedBy: [ aStream nextPutAll: ', ' ].
	aStream nextPut: $}
]

{ #category : #'initialize-release' }
AFMetanotionSubstitutions >> release [
	associations := nil.
	super release
]

{ #category : #accessing }
AFMetanotionSubstitutions >> size [
	^ associations size
]
