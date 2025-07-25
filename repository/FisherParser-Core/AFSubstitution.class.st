"
a substitution to the matching algorithm.




"
Class {
	#name : 'AFSubstitution',
	#superclass : 'Object',
	#classInstVars : [
		'emptySolution',
		'noSolution'
	],
	#category : 'FisherParser-Core-Matching',
	#package : 'FisherParser-Core',
	#tag : 'Matching'
}

{ #category : 'instance creation' }
AFSubstitution class >> emptySolution [
	" an empty solution "

	^ emptySolution ifNil: [ emptySolution := AFSolution empty ]
]

{ #category : 'class initialization' }
AFSubstitution class >> initialize [
	emptySolution := noSolution := nil
]

{ #category : 'instance creation' }
AFSubstitution class >> noSolution [
	" no solution is possible "

	^ noSolution ifNil: [ noSolution := AFNoSolution new ]
]

{ #category : 'class initialization' }
AFSubstitution class >> reset [
	" reset the usual solutions "

	emptySolution := noSolution := nil
]

{ #category : 'instance creation' }
AFSubstitution class >> solution: aMetanotionSubstitutions [
	" a solution is possible with the given substitutions.
		{(aMetanotion -> substitute). etc.} "

	^ AFSolution substitutions: aMetanotionSubstitutions
]

{ #category : 'instance creation' }
AFSubstitution class >> solutionWith: anAssociation [
	^ AFSolution with: anAssociation
]

{ #category : 'instance creation' }
AFSubstitution class >> solutionWithAll: anAssocCollection [
	^ AFSolution withAll: anAssocCollection
]

{ #category : 'accessing' }
AFSubstitution >> applyTo: aMetanotion [
	self subclassResponsibility
]

{ #category : 'displaying' }
AFSubstitution >> displaySubstitutionStringOn: aStream [

	^ self subclassResponsibility
]

{ #category : 'testing' }
AFSubstitution >> ifSolution: aBlock [
	"Evaluate a block when I'm a solution"

	self subclassResponsibility
]

{ #category : 'testing' }
AFSubstitution >> isSolution [
	"if this substitution is a solution to the syntactic matching problem"

	self subclassResponsibility
]

{ #category : 'printing' }
AFSubstitution >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]

{ #category : 'accessing' }
AFSubstitution >> union: anAFSolution [
	self subclassResponsibility
]
