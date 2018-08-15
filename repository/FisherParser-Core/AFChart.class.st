"
chart that hold the columns.

"
Class {
	#name : #AFChart,
	#superclass : #Object,
	#instVars : [
		'columns'
	],
	#category : #'FisherParser-Core-Implementation'
}

{ #category : #'instance creation' }
AFChart class >> new: size [
	^ self basicNew
		initializeSize: size;
		yourself
]

{ #category : #accessing }
AFChart >> at: index [
	^ columns at: index
]

{ #category : #testing }
AFChart >> columnSizes [
	^ columns collect: [ :each | each size ]
]

{ #category : #accessing }
AFChart >> first [
	^ columns first
]

{ #category : #'inspector extensions' }
AFChart >> gtInspectorColumnsIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ composite table
		title: [ columns size asString , ' columns' ];
		display: [ columns ];
		column: 'Column' evaluated: [ :each | each ];
		showOnly: 50;
		yourself
]

{ #category : #initialization }
AFChart >> initializeSize: sizeRequested [
	columns := Array new: sizeRequested.
	1 to: columns size do: [ :index | columns at: index put: (AFColumn number: index) ]
]

{ #category : #accessing }
AFChart >> last [
	^ columns last
]

{ #category : #printing }
AFChart >> printOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPut: $(;
		print: columns size;
		nextPutAll: ' columns)'
]

{ #category : #printing }
AFChart >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]

{ #category : #'initialize-release' }
AFChart >> release [
	columns := nil.
	super release
]

{ #category : #accessing }
AFChart >> size [
	^ columns size
]

{ #category : #enumerating }
AFChart >> withIndexDo: elementAndIndexBlock [
	1 	to: columns size 
		do: [ :index | 
					elementAndIndexBlock 
						value: (self at: index) 
						value: index ]
]
