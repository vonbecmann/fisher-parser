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
		equals: 'AFSolution(AFMetanotionSubstitutions())'
]

{ #category : #tests }
AFSubstitutionTest >> testNoSolutionAsString [
	self 
		assert: AFSubstitution noSolution asString 
		equals: 'AFNoSolution()'
]

{ #category : #tests }
AFSubstitutionTest >> testSolutionAsString [
	self
		assert:
			(AFSubstitution 
				solutionWith: 
					(AWMetanotion named: 'LETTER') -> (AWProtonotion with: 'a')) asString
		equals: 'AFSolution(AFMetanotionSubstitutions(LETTER->a))'
]

{ #category : #tests }
AFSubstitutionTest >> testSolutionAsString02 [
	self
		assert:
			(AFSubstitution
				solutionWithAll:
					{((AWMetanotion named: 'LETTER') -> (AWProtonotion with: 'a')).
					((AWMetanotion named: 'ALPHA') -> (AWProtonotion with: 'b'))}) asString
		equals: 'AFSolution(AFMetanotionSubstitutions(LETTER->a, ALPHA->b))'
]
