"
a packed parse node.
"
Class {
	#name : #AFPackedNode,
	#superclass : #Object,
	#instVars : [
		'model',
		'families'
	],
	#category : #'FisherParser-Core-BSPPForest'
}

{ #category : #'instance creation' }
AFPackedNode class >> model: anItem [
	^ self basicNew initializeModel: anItem
]

{ #category : #comparing }
AFPackedNode >> = anObject [
	^ self class == anObject class and: [ model = anObject model ]
]

{ #category : #visiting }
AFPackedNode >> acceptPostOrderVisitor: aVisitor [
	aVisitor visitPostOrderPackedNode: self
]

{ #category : #visiting }
AFPackedNode >> acceptPreOrderVisitor: aVisitor [
	aVisitor visitPreOrderPackedNode: self
]

{ #category : #visiting }
AFPackedNode >> acceptVisitor: aVisitor [
	aVisitor visitNode: self
]

{ #category : #accessing }
AFPackedNode >> addEmptyFamily [
	self addFamily: AFFamily empty
]

{ #category : #accessing }
AFPackedNode >> addFamily: aFamily [
	families
		detect: [ :family | family first = aFamily first and: [ family second = aFamily second ] ]
		ifFound: [ :element | element ]
		ifNone: [ 
			aFamily parent: self.
			families add: aFamily ]
]

{ #category : #visiting }
AFPackedNode >> children [
	^ families asArray
]

{ #category : #displaying }
AFPackedNode >> displayStringOn: aStream [

	aStream nextPut: $(.
	model displayStringOn: aStream.
	aStream nextPut: $)
]

{ #category : #accessing }
AFPackedNode >> families [
	^ families
]

{ #category : #accessing }
AFPackedNode >> familiesSize [
	^ families size
]

{ #category : #comparing }
AFPackedNode >> hash [
	^ (self class hash + model hash) hashMultiply
]

{ #category : #initialization }
AFPackedNode >> initializeModel: anItem [
	families := SinglyLinkedList new.
	model := anItem
]

{ #category : #'inspector extensions' }
AFPackedNode >> inspectionBrowserIn: aBuilder [

	<inspectorPresentationOrder: 1 title: 'Browse'>
	^ aBuilder newTree
		  roots: { self };
		  children: [ :each | each children ];
		  display: [ :each | StObjectPrinter asTruncatedTextFrom: each ];
		  yourself
]

{ #category : #testing }
AFPackedNode >> isAmbiguous [
	AFDepthFirstVisitor new
		preOrderNodeBlock: [ :packed | 
			packed familiesSize > 1
				ifTrue: [ ^ true ] ];
		visit: self.
	^ false
]

{ #category : #accessing }
AFPackedNode >> model [
	^ model
]

{ #category : #printing }
AFPackedNode >> printOn: aStream [
	aStream
		nextPutAll: self className;
		nextPut: $(;
		print: model;
		nextPut: $)
]

{ #category : #printing }
AFPackedNode >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]

{ #category : #'initialize-release' }
AFPackedNode >> release [
	model := nil.
	families := nil.
	super release
]
