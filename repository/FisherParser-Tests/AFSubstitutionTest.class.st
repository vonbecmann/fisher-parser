Class {
	#name : #AFSubstitutionTest,
	#superclass : #TestCase,
	#category : #'FisherParser-Tests-MetaMatching'
}

{ #category : #tests }
AFSubstitutionTest >> testEmptySolutionAsString [
	self 
		assert: AFSubstitution emptySolution asString 
		equals: 'substitution({})'
]

{ #category : #tests }
AFSubstitutionTest >> testNoSolutionAsString [
	self 
		assert: AFSubstitution noSolution asString 
		equals: 'substitution(no solution)'
]

{ #category : #tests }
AFSubstitutionTest >> testSolutionAsString [
	self
		assert:
			(AFSubstitution 
				solutionWith: 
					(AWMetanotion named: 'LETTER') -> (AWProtonotion with: 'a')) asString
		equals: 'substitution({LETTER->a})'
]

{ #category : #tests }
AFSubstitutionTest >> testSolutionAsString02 [
	self
		assert:
			(AFSubstitution
				solutionWithAll:
					{((AWMetanotion named: 'LETTER') -> (AWProtonotion with: 'a')).
					((AWMetanotion named: 'ALPHA') -> (AWProtonotion with: 'b'))}) asString
		equals: 'substitution({LETTER->a, ALPHA->b})'
]
