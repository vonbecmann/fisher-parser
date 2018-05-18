Class {
	#name : #AFAVWGrammarTest,
	#superclass : #TestCase,
	#category : #'FisherParser-Tests'
}

{ #category : #tests }
AFAVWGrammarTest >> testRepresentationsIsEmpty [
	self 
		should: [ AVWGrammar evw: 'EMPTY::. program:.' representations: #() ] 
		raise: Error
]
