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

{ #category : #accessing }
AFPackedNode >> families [
	^ families
]

{ #category : #accessing }
AFPackedNode >> familiesSize [
	^ families size
]

{ #category : #'inspector extensions' }
AFPackedNode >> gtDisplayOn: aStream [
	aStream nextPut: $(.
	model gtDisplayOn: aStream.
	aStream nextPut: $)
]

{ #category : #'inspector extensions' }
AFPackedNode >> gtInspectorFamiliesIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ composite list
		title: [ 'Families' ];
		display: [ families asArray ];
		format: [ :each | GTObjectPrinter asTruncatedTextFrom: each ];
		showOnly: 50;
		yourself
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