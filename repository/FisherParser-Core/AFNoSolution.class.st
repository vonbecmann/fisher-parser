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
	self error: self asString
]

{ #category : #testing }
AFNoSolution >> ifSolution: aBlock [
	"Return self because I'm not a solution"

	^ self
]

{ #category : #testing }
AFNoSolution >> isEmpty [
	self error: self asString
]

{ #category : #testing }
AFNoSolution >> isSolution [
	^ false
]

{ #category : #printing }
AFNoSolution >> printOn: aStream [
	aStream nextPutAll: 'substitution(no solution)'
]
