"
grammar examples as a test resource
"
Class {
	#name : #AFExemplarResource,
	#superclass : #TestResource,
	#instVars : [
		'a3b3c3',
		'starSequence',
		'anbncn'
	],
	#category : #'FisherParser-Tests-Grammar'
}

{ #category : #accessing }
AFExemplarResource >> a3b3c3 [
	^ a3b3c3
]

{ #category : #accessing }
AFExemplarResource >> anbncn [
	^ anbncn
]

{ #category : #running }
AFExemplarResource >> setUp [
	super setUp.
	a3b3c3 := AFExemplar a3b3c3.
	starSequence := AFExemplar starSequence.
	anbncn := AFExemplar anbncn.
	
]

{ #category : #accessing }
AFExemplarResource >> starSequence [
	^ starSequence
]

{ #category : #running }
AFExemplarResource >> tearDown [
	"Does nothing. Subclasses should override this to tear down their resource"

	a3b3c3 := starSequence := anbncn := nil.
	super tearDown
]
