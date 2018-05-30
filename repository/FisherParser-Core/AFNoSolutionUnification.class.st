"
no solution sustitution
"
Class {
	#name : #AFNoSolutionUnification,
	#superclass : #Object,
	#category : #'FisherParser-Core-MetaUnification'
}

{ #category : #public }
AFNoSolutionUnification >> unifyWith: aHypernotion [
	"no solution"

	^ AFSubstitution noSolution
]
