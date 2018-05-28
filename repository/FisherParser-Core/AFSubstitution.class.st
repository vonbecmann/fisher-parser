"
a solution substitution to the ""syntactic unification problem"".



"
Class {
	#name : #AFSubstitution,
	#superclass : #Object,
	#instVars : [
		'solution',
		'metanotionSubstitutions'
	],
	#category : #'FisherParser-Core-Implementation'
}

{ #category : #'instance creation' }
AFSubstitution class >> failed [
	^ self basicNew
		initializeSolution: false substitutions: #();
		yourself
]

{ #category : #'instance creation' }
AFSubstitution class >> solution: anAssocCollection [
	^ self basicNew
		initializeSolution: true substitutions: anAssocCollection;
		yourself
]

{ #category : #accessing }
AFSubstitution >> at: aMetanotion [
	^ metanotionSubstitutions 
			detect: [ :each | each key = aMetanotion named ] 
			ifFound: [ :each | each value ] 
			ifNone: [ aMetanotion ]
]

{ #category : #initialization }
AFSubstitution >> initializeSolution: aBoolean substitutions: anAssocCollection [
	self initialize.
	solution := aBoolean.
	metanotionSubstitutions := anAssocCollection
]

{ #category : #testing }
AFSubstitution >> isSolution [
	"if this substitution is a solution to the unification problem"

	^ solution
]

{ #category : #printing }
AFSubstitution >> printOn: aStream [
	aStream
		nextPutAll: self className;
		nextPut: $(.
	solution
		ifTrue: [ 
			aStream nextPut: ${.
			metanotionSubstitutions 
				do: [ :assoc | 
					aStream
						print: assoc key;
						nextPutAll: '->';
						print: assoc value ]
				separatedBy: [ aStream nextPutAll: ', ' ].
			aStream nextPut: $} ]
		ifFalse: [ aStream nextPutAll: 'no solution' ].
	aStream nextPut: $)
]

{ #category : #printing }
AFSubstitution >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]
