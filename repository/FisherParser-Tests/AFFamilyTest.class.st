Class {
	#name : #AFFamilyTest,
	#superclass : #TestCase,
	#category : #'FisherParser-Tests-BSPPForest'
}

{ #category : #tests }
AFFamilyTest >> testEquals [
	self assert: AFFamily empty equals: AFFamily empty
]

{ #category : #tests }
AFFamilyTest >> testIsEmpty [
	self assert: AFFamily empty isEmpty
]
