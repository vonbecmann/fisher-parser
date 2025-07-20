"
first attempt to recognize a string of a vw grammar
"
Class {
	#name : 'AFRecognizer',
	#superclass : 'AFYoYoAlgorithm',
	#category : 'FisherParser-Core-Implementation',
	#package : 'FisherParser-Core',
	#tag : 'Implementation'
}

{ #category : 'testing' }
AFRecognizer >> accepts: aString [
	^ [ | chart |
	chart := self evaluate: aString.
	chart last includesInstanceOf: (grammar startHyperRule dotAtEnd startAt: chart first) ]
		on: AFFailure
		do: [ :ex | false ]
]

{ #category : 'private' }
AFRecognizer >> complete: item [

	item predictionItemsDo: [ :previous |
			previous symbolAtDot match: item head do: [ :substitution |
				item end add: (previous moveDotForwardAfterApplying: substitution) ] ]
]

{ #category : 'private' }
AFRecognizer >> gapScan: item [
	" gap scanner "

	item symbolAtDot matchEmptyDo: [ :substitution |
		item end add: (item moveDotForwardAfterApplying: substitution) ]
]

{ #category : 'private' }
AFRecognizer >> scan: item with: word at: aColumn [
	" terminal scanner "

	aColumn add: item moveDotForward
]
