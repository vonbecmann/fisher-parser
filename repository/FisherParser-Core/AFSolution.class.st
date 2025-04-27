"
a solution substitution to the matching algorithm.




"
Class {
	#name : 'AFSolution',
	#superclass : 'AFSubstitution',
	#instVars : [
		'metanotionSubstitutions'
	],
	#category : 'FisherParser-Core-Matching',
	#package : 'FisherParser-Core',
	#tag : 'Matching'
}

{ #category : 'instance creation' }
AFSolution class >> empty [
	^ self substitutions: AFMetanotionSubstitutions empty
]

{ #category : 'instance creation' }
AFSolution class >> substitutions: aMetanotionSubstitutions [
	^ self basicNew
		initializeSubstitutions: aMetanotionSubstitutions;
		yourself
]

{ #category : 'instance creation' }
AFSolution class >> with: anAssociation [
	^ self substitutions: (AFMetanotionSubstitutions with: anAssociation)
]

{ #category : 'instance creation' }
AFSolution class >> withAll: anAssocCollection [
	^ self substitutions: (AFMetanotionSubstitutions withAll: anAssocCollection)
]

{ #category : 'comparing' }
AFSolution >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].
	self class == anObject class
		ifFalse: [ ^ false ].
	^ metanotionSubstitutions = anObject metanotionSubstitutions
]

{ #category : 'accessing' }
AFSolution >> applyTo: aMetanotion [
	^ metanotionSubstitutions at: aMetanotion
]

{ #category : 'displaying' }
AFSolution >> displayStringOn: aStream [

	aStream nextPutAll: 'solution('.
	metanotionSubstitutions displayStringOn: aStream.
	aStream nextPut: $)
]

{ #category : 'displaying' }
AFSolution >> displaySubstitutionStringOn: aStream [

	metanotionSubstitutions displayStringOn: aStream
]

{ #category : 'comparing' }
AFSolution >> hash [
	^ (self class hash + metanotionSubstitutions hash) hashMultiply
]

{ #category : 'testing' }
AFSolution >> ifSolution: aBlock [
	"Evaluate a block because I'm a solution"

	^ aBlock cull: self
]

{ #category : 'initialization' }
AFSolution >> initializeSubstitutions: aMetanotionSubstitutions [
	metanotionSubstitutions := aMetanotionSubstitutions
]

{ #category : 'inspector extensions' }
AFSolution >> inspectionSubstitutionsIn: aBuilder [

	<inspectorPresentationOrder: 0 title: 'Solution'>
	^ (metanotionSubstitutions inspectionSubstitutionsIn: aBuilder)
		  yourself
]

{ #category : 'testing' }
AFSolution >> isEmpty [
	^ metanotionSubstitutions isEmpty
]

{ #category : 'testing' }
AFSolution >> isSolution [
	^ true
]

{ #category : 'accessing' }
AFSolution >> metanotionSubstitutions [
	^ metanotionSubstitutions
]

{ #category : 'printing' }
AFSolution >> printOn: aStream [
	aStream
		nextPutAll: self className;
		nextPut: $(;
		print: metanotionSubstitutions;
		nextPut: $)
]

{ #category : 'initialize-release' }
AFSolution >> release [
	metanotionSubstitutions := nil.
	super release
]

{ #category : 'accessing' }
AFSolution >> union: anAFSolution [
	^ anAFSolution withAll: metanotionSubstitutions
]

{ #category : 'instance creation' }
AFSolution >> withAll: anAFMetanotionSubstitutions [
	^ self class substitutions: (anAFMetanotionSubstitutions union: metanotionSubstitutions)
]
