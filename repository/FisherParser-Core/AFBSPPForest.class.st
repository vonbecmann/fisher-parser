"
Binary 
Shared 
Packed
Parse 
Forest 

"
Class {
	#name : 'AFBSPPForest',
	#superclass : 'Object',
	#instVars : [
		'root'
	],
	#category : 'FisherParser-Core-BSPPForest',
	#package : 'FisherParser-Core',
	#tag : 'BSPPForest'
}

{ #category : 'instance creation' }
AFBSPPForest class >> root: aPackedNode [
	^ self basicNew initializeRoot: aPackedNode
]

{ #category : 'visiting' }
AFBSPPForest >> acceptVisitor: aVisitor [
	aVisitor visit: root
]

{ #category : 'displaying' }
AFBSPPForest >> displayStringOn: aStream [

	aStream
		nextPutAll: self className;
		nextPut: $(.
	root displayStringOn: aStream.
	aStream nextPut: $)
]

{ #category : 'initialization' }
AFBSPPForest >> initializeRoot: aPackedNode [
	root := aPackedNode
]

{ #category : 'inspector extensions' }
AFBSPPForest >> inspectionBrowserIn: aBuilder [
	"to be fix: use asArray for the moment. a linked list doesn't implement sum"

	<inspectorPresentationOrder: 1 title: 'Browse'>
	^ aBuilder newTree
		  roots: { root };
		  children: [ :each | each children asArray ];
		  display: [ :each | StObjectPrinter asTruncatedTextFrom: each ];
		  yourself
]

{ #category : 'printing' }
AFBSPPForest >> printOn: aStream [
	aStream
		nextPutAll: self className;
		nextPut: $(;
		print: root;
		nextPut: $)
]

{ #category : 'printing' }
AFBSPPForest >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]
