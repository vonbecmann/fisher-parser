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

{ #category : #'inspector extensions' }
AFNoSolution >> gtDisplayOn: aStream [
	aStream nextPutAll: 'no solution substitution'
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
