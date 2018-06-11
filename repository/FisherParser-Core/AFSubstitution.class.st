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

	^ emptySolution
		ifNil: [ 
			emptySolution := 
				self 
					solution: true 
					substitutions: AFMetanotionSubstitutions empty ]
]

{ #category : #'class initialization' }
AFSubstitution class >> initialize [
	emptySolution := noSolution := nil
]

{ #category : #'instance creation' }
AFSubstitution class >> noSolution [
	" no solution is possible "

	^ noSolution
		ifNil: [ 
			noSolution := 
				self 
					solution: false 
					substitutions: AFMetanotionSubstitutions empty ]
]

{ #category : #accessing }
AFSubstitution class >> reset [
	" reset the usual solutions "

	emptySolution := noSolution := nil
]

{ #category : #'instance creation' }
AFSubstitution class >> solution: aMetanotionSubstitutions [
	" a solution is possible with the given substitutions.
		{(aMetanotion -> substitute). etc.} "

	^ self solution: true substitutions: aMetanotionSubstitutions
]

{ #category : #private }
AFSubstitution class >> solution: aBoolean substitutions: aMetanotionSubstitutions [
	^ self basicNew
		initializeSolution: aBoolean substitutions: aMetanotionSubstitutions;
		yourself
]

{ #category : #'instance creation' }
AFSubstitution class >> solutionWith: anAssociation [
	^ self solution: (AFMetanotionSubstitutions with: anAssociation)
]

{ #category : #'instance creation' }
AFSubstitution class >> solutionWithAll: anAssocCollection [ 
	^ self solution: (AFMetanotionSubstitutions withAll: anAssocCollection) 
]

{ #category : #accessing }
AFSubstitution >> at: aMetanotion [
	^ metanotionSubstitutions at: aMetanotion
]

{ #category : #'inspector extensions' }
AFSubstitution >> gtInspectorSubstitutionIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ (metanotionSubstitutions gtInspectorSubstitutionsIn: composite)
		title: [ 
			solution
				ifTrue: [ 'Solution' ]
				ifFalse: [ 'No Solution' ] ];
		yourself
]

{ #category : #initialization }
AFSubstitution >> initializeSolution: aBoolean substitutions: aMetanotionSubstitutions [
	self initialize.
	solution := aBoolean.
	metanotionSubstitutions := aMetanotionSubstitutions
]

{ #category : #testing }
AFSubstitution >> isSolution [
	"if this substitution is a solution to the syntactic matching problem"

	^ solution
]

{ #category : #printing }
AFSubstitution >> printOn: aStream [
	aStream nextPutAll: 'substitution('.
	solution
		ifTrue: [ aStream print: metanotionSubstitutions ]
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
