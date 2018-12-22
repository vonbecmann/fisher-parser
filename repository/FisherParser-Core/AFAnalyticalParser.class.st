"
analyze the parsing of a string.
"
Class {
	#name : #AFAnalyticalParser,
	#superclass : #AFParser,
	#category : #'FisherParser-Core-Implementation'
}

{ #category : #parsing }
AFAnalyticalParser >> parse: aString [
	^ [ | chart forest |
	chart := self evaluate: aString.
	forest := chart last
		like: (grammar startHyperRule dotAtEnd startAt: chart first)
		ifFound: [ :found | self newParseForestWith: found ]
		ifNone: [ AFFailure signal ].
	OrderedDictionary
		newFrom:
			{('chart' -> chart).
			('accepts' -> true).
			('forest' -> forest).
			('chart stats'
				->
					(OrderedDictionary
						newFrom:
							{('each column size' -> chart columnSizes).
							('total item count' -> chart columnSizes sum)}))} ]
		on: AFFailure
		do: [ :ex | 
			Dictionary
				newFrom:
					{('expected symbols' -> ex expectedSymbols).
					('position' -> ex position).
					('accepts' -> false).
					('message' -> ex messageText)} ]
]
