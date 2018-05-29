"
vw-grammar tests.

"
Class {
	#name : #AFAVWGrammarTest,
	#superclass : #TestCase,
	#category : #'FisherParser-Tests-Grammar'
}

{ #category : #tests }
AFAVWGrammarTest >> testRepresentationsIsEmpty [
	self 
		should: [ AVWGrammar evw: 'EMPTY::. program:.' representations: #() ] 
		raise: Error
]
