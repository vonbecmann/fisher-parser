"
no solution substitution.
failed.

"
Class {
	#name : #AFNoSolution,
	#superclass : #AFSubstitution,
	#category : #'FisherParser-Core-Matching'
}

{ #category : #accessing }
AFNoSolution >> applyTo: aMetanotion [
	" I'm not a solution, there isn't a possible substitution "

	self shouldNotImplement
]

{ #category : #displaying }
AFNoSolution >> displayStringOn: aStream [
	aStream nextPutAll: 'no solution substitution'
]

{ #category : #displaying }
AFNoSolution >> displaySubstitutionStringOn: aStream [

	aStream nextPutAll: 'failure'
]

{ #category : #testing }
AFNoSolution >> ifSolution: aBlock [
	"Return self because I'm not a solution"

	^ self
]

{ #category : #testing }
AFNoSolution >> isSolution [
	^ false
]

{ #category : #printing }
AFNoSolution >> printOn: aStream [
	aStream
		nextPutAll: self className;
		nextPutAll: '()'
]

{ #category : #accessing }
AFNoSolution >> union: anAFSolution [
	" I'm not a solution, there isn't a possible substitution "

	self shouldNotImplement
]
