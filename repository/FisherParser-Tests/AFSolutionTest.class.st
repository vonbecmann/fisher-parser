Class {
	#name : #AFSolutionTest,
	#superclass : #TestCase,
	#category : #'FisherParser-Tests-Matching'
}

{ #category : #tests }
AFSolutionTest >> testEqual01 [
	| one other |
	one := AFSolution
		withAll:
			{(#ALPHA1 asNotion -> 'a' asNotion).
			(#ALPHA2 asNotion -> 'a' asNotion)}.
	other := AFSolution
		withAll:
			{(#ALPHA1 asNotion -> 'a' asNotion).
			(#ALPHA2 asNotion -> 'a' asNotion)}.
	self assert: one equals: other.
	self assert: one hash equals: other hash
]

{ #category : #tests }
AFSolutionTest >> testEqual02 [
	| one other |
	one := AFSolution
		withAll:
			{(#ALPHA2 asNotion -> 'a' asNotion).
			(#ALPHA1 asNotion -> 'a' asNotion)}.
	other := AFSolution
		withAll:
			{(#ALPHA1 asNotion -> 'a' asNotion).
			(#ALPHA2 asNotion -> 'a' asNotion)}.
	self assert: one equals: other.
	self assert: one hash equals: other hash
]

{ #category : #tests }
AFSolutionTest >> testEqual03 [
	| one other |
	one := AFSolution withAll: {(#ALPHA2 asNotion -> 'a' asNotion)}.
	other := AFSolution withAll: {(#ALPHA2 asNotion -> 'b' asNotion)}.
	self deny: one equals: other
]
