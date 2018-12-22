"
analyze the recognition of a string.
"
Class {
	#name : #AFAnalyticalRecognizer,
	#superclass : #AFRecognizer,
	#category : #'FisherParser-Core-Implementation'
}

{ #category : #testing }
AFAnalyticalRecognizer >> accepts: aString [
	^ [ | chart |
	chart := self evaluate: aString.
	OrderedDictionary
		newFrom:
			{('chart' -> chart).
			('accepts'
				-> (chart last includes: (grammar startHyperRule dotAtEnd startAt: chart first))).
			('chart stats'
				->
					(OrderedDictionary
						newFrom:
							{('each column size' -> chart columnSizes).
							('total item count' -> chart columnSizes sum)}))} ]
		on: AFFailure
		do: [ :ex | 
			OrderedDictionary
				newFrom:
					{('accepts' -> false).
					('exception' -> ex)} ]
]
