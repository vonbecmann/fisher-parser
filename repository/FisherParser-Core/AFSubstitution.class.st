"
a solution substitution to the matching algorithm.




"
Class {
	#name : #AFSubstitution,
	#superclass : #Object,
	#instVars : [
		'solution',
		'metanotionSubstitutions'
	],
	#classInstVars : [
		'emptySolution',
		'noSolution'
	],
	#category : #'FisherParser-Core-MetaMatching'
}

{ #category : #'instance creation' }
AFSubstitution class >> emptySolution [
	" an empty solution "

	^ emptySolution ifNil: [ emptySolution := self solution: true substitutions: #() ]
]

{ #category : #'class initialization' }
AFSubstitution class >> initialize [
	emptySolution := noSolution := nil
]

{ #category : #'instance creation' }
AFSubstitution class >> noSolution [
	" no solution is possible "

	^ noSolution ifNil: [ noSolution := self solution: false substitutions: #() ]
]

{ #category : #accessing }
AFSubstitution class >> reset [
	" reset the usual solutions "

	emptySolution := noSolution := nil
]

{ #category : #'instance creation' }
AFSubstitution class >> solution: anAssocCollection [
	" a solution is possible with the given substitutions.
		{(aMetanotion -> substitute). etc.} "

	^ self solution: true substitutions: anAssocCollection
]

{ #category : #private }
AFSubstitution class >> solution: aBoolean substitutions: anAssocCollection [
	^ self basicNew
		initializeSolution: aBoolean substitutions: anAssocCollection;
		yourself
]

{ #category : #accessing }
AFSubstitution >> at: aMetanotion [
	metanotionSubstitutions
		do: [ :assoc | 
			assoc key = aMetanotion
				ifTrue: [ ^ assoc value ] ].
	^ aMetanotion
]

{ #category : #initialization }
AFSubstitution >> initializeSolution: aBoolean substitutions: anAssocCollection [
	self initialize.
	solution := aBoolean.
	metanotionSubstitutions := anAssocCollection
]

{ #category : #testing }
AFSubstitution >> isSolution [
	"if this substitution is a solution to the syntactic unification problem"

	^ solution
]

{ #category : #printing }
AFSubstitution >> printOn: aStream [
	aStream nextPutAll: 'substitution('.
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

{ #category : #'initialize-release' }
AFSubstitution >> release [
	solution := metanotionSubstitutions := nil.
	super release
]
