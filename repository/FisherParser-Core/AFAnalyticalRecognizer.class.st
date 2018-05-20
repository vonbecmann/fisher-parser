"
analize the recognition of a string.
"
Class {
	#name : #AFAnalyticalRecognizer,
	#superclass : #AFRecognizer,
	#category : #'FisherParser-Core-Implementation'
}

{ #category : #testing }
AFAnalyticalRecognizer >> accepts: aString [
	^ self evaluate: aString
]
