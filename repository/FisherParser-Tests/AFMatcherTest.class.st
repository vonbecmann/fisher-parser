"
base class for matcher testing.

"
Class {
	#name : #AFMatcherTest,
	#superclass : #TestCase,
	#category : #'FisherParser-Tests-MetaMatching'
}

{ #category : #testing }
AFMatcherTest class >> isAbstract [
	"Override to true if a TestCase subclass is Abstract and should not have
	TestCase instances built from it"

	^ self name = #AFMatcherTest
]

{ #category : #accessing }
AFMatcherTest class >> resources [
	^ Array with: AFExemplarResource
]

{ #category : #accessing }
AFMatcherTest >> examples [
	^ AFExemplarResource current
]
