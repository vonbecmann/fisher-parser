"
a solution substitution to the matching algorithm.




"
Class {
	#name : #AFSolution,
	#superclass : #AFSubstitution,
	#instVars : [
		'metanotionSubstitutions'
	],
	#category : #'FisherParser-Core-Matching'
}

{ #category : #'instance creation' }
AFSolution class >> empty [
	^ self substitutions: AFMetanotionSubstitutions empty
]

{ #category : #'instance creation' }
AFSolution class >> substitutions: aMetanotionSubstitutions [
	^ self basicNew
		initializeSubstitutions: aMetanotionSubstitutions;
		yourself
]

{ #category : #'instance creation' }
AFSolution class >> with: anAssociation [
	^ self substitutions: (AFMetanotionSubstitutions with: anAssociation)
]

{ #category : #'instance creation' }
AFSolution class >> withAll: anAssocCollection [
	^ self substitutions: (AFMetanotionSubstitutions withAll: anAssocCollection)
]

{ #category : #accessing }
AFSolution >> applyTo: aMetanotion [
	^ metanotionSubstitutions at: aMetanotion
]

{ #category : #'inspector extensions' }
AFSolution >> gtDisplayOn: aStream [
	aStream nextPutAll: 'solution('.
	metanotionSubstitutions gtDisplayOn: aStream.
	aStream nextPut: $)
]

{ #category : #'inspector extensions' }
AFSolution >> gtInspectorSubstitutionIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ (metanotionSubstitutions gtInspectorSubstitutionsIn: composite)
			title: [ 'Solution' ];
			yourself
]

{ #category : #testing }
AFSolution >> ifSolution: aBlock [
	"Evaluate a block because I'm a solution"

	^ aBlock cull: self
]

{ #category : #initialization }
AFSolution >> initializeSubstitutions: aMetanotionSubstitutions [
	metanotionSubstitutions := aMetanotionSubstitutions
]

{ #category : #testing }
AFSolution >> isEmpty [
	^ metanotionSubstitutions isEmpty
]

{ #category : #testing }
AFSolution >> isSolution [
	^ true
]

{ #category : #printing }
AFSolution >> printOn: aStream [
	aStream
		nextPutAll: self className;
		nextPut: $(;
		print: metanotionSubstitutions;
		nextPut: $)
]

{ #category : #'initialize-release' }
AFSolution >> release [
	metanotionSubstitutions := nil.
	super release
]
