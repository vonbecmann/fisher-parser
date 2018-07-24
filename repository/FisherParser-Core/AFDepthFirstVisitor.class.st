Class {
	#name : #AFDepthFirstVisitor,
	#superclass : #AFBSPPFVisitor,
	#category : #'FisherParser-Core-BSPPForest'
}

{ #category : #visiting }
AFDepthFirstVisitor >> visitNode: aPackedOrFamilyNode [
	" status: notvisited -> visited -> done"

	| visitStack visited |
	visitStack := SinglyLinkedStack with: aPackedOrFamilyNode.
	visited := IdentityDictionary new.
	[ visitStack isEmpty ]
		whileFalse: [ | element status |
			element := visitStack top.
			status := visited at: element ifAbsent: #notvisited.
			status == #notvisited
				ifTrue: [ 
					visited at: element put: #visited.
					element acceptPreOrderVisitor: self.
					element children reverseDo: [ :child | visitStack push: child ] ]
				ifFalse: [ 
					status == #visited
						ifTrue: [ 
							visitStack pop.
							element acceptPostOrderVisitor: self.
							visited at: element put: #done ]
						ifFalse: [ 
							status == #done ifTrue: [ visitStack pop ] ] ] ]
]
