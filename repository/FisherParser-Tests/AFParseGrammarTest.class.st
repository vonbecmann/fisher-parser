"
base class for grammar parse testing.

"
Class {
	#name : #AFParseGrammarTest,
	#superclass : #TestCase,
	#instVars : [
		'grammar',
		'forest'
	],
	#category : #'FisherParser-Tests-Parsing'
}

{ #category : #testing }
AFParseGrammarTest class >> isAbstract [
	"Override to true if a TestCase subclass is Abstract and should not have
	TestCase instances built from it"

	^ self name = #AFParseGrammarTest
]

{ #category : #accessing }
AFParseGrammarTest class >> resources [
	^ Array with: AFExemplarResource
]

{ #category : #accessing }
AFParseGrammarTest >> examples [
	^ AFExemplarResource current
]

{ #category : #running }
AFParseGrammarTest >> tearDown [
	grammar := forest := nil.
	super tearDown
]
