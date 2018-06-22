"
substitution test.

"
Class {
	#name : #AFSubstitutionTest,
	#superclass : #TestCase,
	#category : #'FisherParser-Tests-Matching'
}

{ #category : #tests }
AFSubstitutionTest >> testEmptySolutionAsString [
	self 
		assert: AFSubstitution emptySolution asString 
		equals: 'solution({})'
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
		equals: 'solution({LETTER->a})'
]

{ #category : #tests }
AFSubstitutionTest >> testSolutionAsString02 [
	self
		assert:
			(AFSubstitution
				solutionWithAll:
					{((AWMetanotion named: 'LETTER') -> (AWProtonotion with: 'a')).
					((AWMetanotion named: 'ALPHA') -> (AWProtonotion with: 'b'))}) asString
		equals: 'solution({LETTER->a, ALPHA->b})'
]
