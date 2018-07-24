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

{ #category : #initialization }
AFBSPPForest >> initializeRoot: anAFDottedItem [ 
	root := anAFDottedItem 
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
