"
base class for grammar testing.

"
Class {
	#name : #AFGrammarTest,
	#superclass : #TestCase,
	#instVars : [
		'grammar'
	],
	#category : #'FisherParser-Tests-Grammar'
}

{ #category : #testing }
AFGrammarTest class >> isAbstract [
	"Override to true if a TestCase subclass is Abstract and should not have
	TestCase instances built from it"

	^ self name = #AFGrammarTest
]

{ #category : #accessing }
AFGrammarTest class >> resources [
	^ Array with: AFExemplarResource
]

{ #category : #accessing }
AFGrammarTest >> examples [
	^ AFExemplarResource current
]

{ #category : #running }
AFGrammarTest >> tearDown [
	grammar := nil.
	super tearDown
]
