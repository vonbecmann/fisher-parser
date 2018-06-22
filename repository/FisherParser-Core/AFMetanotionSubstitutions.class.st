"
metanotion -> substitute.

"
Class {
	#name : #AFMetanotionSubstitutions,
	#superclass : #Object,
	#instVars : [
		'associations'
	],
	#category : #'FisherParser-Core-Matching'
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
	anAssocCollection do: [ :assoc | self add: assoc ]
]

{ #category : #accessing }
AFMetanotionSubstitutions >> at: aMetanotion [
	associations
		do: [ :assoc | 
			assoc key = aMetanotion
				ifTrue: [ ^ assoc value ] ].
	^ aMetanotion
]

{ #category : #'inspector extensions' }
AFMetanotionSubstitutions >> gtInspectorSubstitutionsIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ composite table
		title: [ 'Substitutions' ];
		display: [ associations asArray ];
		column: 'Metanotion'
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each key ];
		column: 'Substitute'
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each value ];
		send: [ :each | each value ];
		showOnly: 50;
		yourself
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

{ #category : #testing }
AFMetanotionSubstitutions >> isEmpty [
	^ associations isEmpty 
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
