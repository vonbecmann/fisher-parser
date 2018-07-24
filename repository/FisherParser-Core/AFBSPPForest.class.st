Class {
	#name : #AFBSPPForest,
	#superclass : #Object,
	#instVars : [
		'root'
	],
	#category : #'FisherParser-Core-BSPPForest'
}

{ #category : #'instance creation' }
AFBSPPForest class >> root: aPackedNode [
	^ self basicNew initializeRoot: aPackedNode
]

{ #category : #visiting }
AFBSPPForest >> acceptVisitor: aVisitor [
	aVisitor visit: root
]

{ #category : #'inspector extensions' }
AFBSPPForest >> gtDisplayOn: aStream [
	aStream
		nextPutAll: self className;
		nextPut: $(.
	root gtDisplayOn: aStream.
	aStream nextPut: $)
]

{ #category : #'inspector extensions' }
AFBSPPForest >> gtInspectorBrowserIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ composite tree
		title: 'Browse';
		display: [ root ];
		children: [ :each | each children ];
		format: [ :each | GTObjectPrinter asTruncatedTextFrom: each ];
		yourself
]

{ #category : #initialization }
AFBSPPForest >> initializeRoot: aPackedNode [
	root := aPackedNode
]

{ #category : #printing }
AFBSPPForest >> printOn: aStream [
	aStream
		nextPutAll: self className;
		nextPut: $(;
		print: root;
		nextPut: $)
]

{ #category : #printing }
AFBSPPForest >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]
