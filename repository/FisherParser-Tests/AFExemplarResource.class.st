"
grammar examples as a test resource
"
Class {
	#name : #AFExemplarResource,
	#superclass : #TestResource,
	#instVars : [
		'a3b3c3'
	],
	#category : #'FisherParser-Tests-Grammar'
}

{ #category : #accessing }
AFExemplarResource >> a3b3c3 [
	^ a3b3c3
]

{ #category : #running }
AFExemplarResource >> setUp [
	super setUp.
	a3b3c3 := AFExemplar a3b3c3
]

{ #category : #running }
AFExemplarResource >> tearDown [
	"Does nothing. Subclasses should override this to tear down their resource"

	a3b3c3 := nil.
	super tearDown
]
