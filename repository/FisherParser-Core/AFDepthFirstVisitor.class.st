"
left to right 
depth first visitor 
of 
a binary shared packed parse forest.
"
Class {
	#name : 'AFDepthFirstVisitor',
	#superclass : 'AFBSPPFVisitor',
	#category : 'FisherParser-Core-BSPPForest',
	#package : 'FisherParser-Core',
	#tag : 'BSPPForest'
}

{ #category : 'visiting' }
AFDepthFirstVisitor >> visitNode: aPackedOrFamilyNode [

	" status: notvisited(0) -> visited(1) -> done(2)"

	| visitStack visited |
	visitStack := SinglyLinkedStack with: aPackedOrFamilyNode.
	visited := IdentityDictionary new.
	[ visitStack isEmpty ] whileFalse: [ 
		| element status |
		element := visitStack top.
		status := visited at: element ifAbsent: 0.
		status == 0
			ifTrue: [ 
				visited at: element put: 1.
				element acceptPreOrderVisitor: self.
				element children reverseDo: [ :child | visitStack push: child ] ]
			ifFalse: [ 
				status == 1
					ifTrue: [ 
						visitStack pop.
						element acceptPostOrderVisitor: self.
						visited at: element put: 2 ]
					ifFalse: [ status == 2 ifTrue: [ visitStack pop ] ] ] ]
]
