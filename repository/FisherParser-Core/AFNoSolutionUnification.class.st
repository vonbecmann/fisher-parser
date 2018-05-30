"
no solution sustitution
"
Class {
	#name : #AFNoSolutionUnification,
	#superclass : #Object,
	#category : #'FisherParser-Core-MetaUnification'
}

{ #category : #printing }
AFNoSolutionUnification >> printOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPutAll: '(no solution)'
]

{ #category : #printing }
AFNoSolutionUnification >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]

{ #category : #public }
AFNoSolutionUnification >> unifyWith: aHypernotion [
	"no solution"

	^ AFSubstitution noSolution
]
