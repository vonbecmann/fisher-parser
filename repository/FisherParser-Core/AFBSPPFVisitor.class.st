"
Binary 
Shared 
Packed
Parse 
Forest 
Visitor.

"
Class {
	#name : 'AFBSPPFVisitor',
	#superclass : 'Object',
	#instVars : [
		'postOrderFamilyBlock',
		'postOrderNodeBlock',
		'preOrderFamilyBlock',
		'preOrderNodeBlock'
	],
	#category : 'FisherParser-Core-BSPPForest',
	#package : 'FisherParser-Core',
	#tag : 'BSPPForest'
}

{ #category : 'initialization' }
AFBSPPFVisitor >> postOrderFamilyBlock: aBlockWithOneArgument [
	postOrderFamilyBlock := aBlockWithOneArgument
]

{ #category : 'initialization' }
AFBSPPFVisitor >> postOrderNodeBlock: aBlockWithOneArgument [
	postOrderNodeBlock := aBlockWithOneArgument
]

{ #category : 'initialization' }
AFBSPPFVisitor >> preOrderFamilyBlock: aBlockWithOneArgument [
	preOrderFamilyBlock := aBlockWithOneArgument
]

{ #category : 'initialization' }
AFBSPPFVisitor >> preOrderNodeBlock: aBlockWithOneArgument [
	preOrderNodeBlock := aBlockWithOneArgument
]

{ #category : 'visiting' }
AFBSPPFVisitor >> visit: aBSPPForest [
	aBSPPForest acceptVisitor: self
]

{ #category : 'visiting' }
AFBSPPFVisitor >> visitNode: aPackedOrFamilyNode [
	self subclassResponsibility
]

{ #category : 'visiting' }
AFBSPPFVisitor >> visitPostOrderFamily: aFamily [
	"visit in post-order a family"

	postOrderFamilyBlock ifNotNil: [ postOrderFamilyBlock cull: aFamily ]
]

{ #category : 'visiting' }
AFBSPPFVisitor >> visitPostOrderPackedNode: aPackedNode [
	"visit in post-order a node"

	postOrderNodeBlock ifNotNil: [ postOrderNodeBlock cull: aPackedNode ]
]

{ #category : 'visiting' }
AFBSPPFVisitor >> visitPreOrderFamily: aFamily [
	"visit in pre-order a family"

	preOrderFamilyBlock ifNotNil: [ preOrderFamilyBlock cull: aFamily ]
]

{ #category : 'visiting' }
AFBSPPFVisitor >> visitPreOrderPackedNode: aPackedNode [
	"visit in pre-order a node"

	preOrderNodeBlock ifNotNil: [ preOrderNodeBlock cull: aPackedNode ]
]
