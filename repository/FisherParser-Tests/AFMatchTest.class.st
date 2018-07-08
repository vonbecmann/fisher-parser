"
base class for matcher testing.

"
Class {
	#name : #AFMatchTest,
	#superclass : #TestCase,
	#category : #'FisherParser-Tests-Matching'
}

{ #category : #testing }
AFMatchTest class >> isAbstract [
	"Override to true if a TestCase subclass is Abstract and should not have
	TestCase instances built from it"

	^ self name = #AFMatchTest
]

{ #category : #accessing }
AFMatchTest class >> resources [
	^ Array with: AFExemplarResource
]

{ #category : #accessing }
AFMatchTest >> examples [
	^ AFExemplarResource current
]
