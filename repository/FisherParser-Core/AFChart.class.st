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

{ #category : #initialization }
AFChart >> initializeSize: sizeRequested [
	self initialize.
	columns := Array new: sizeRequested.
	1 to: columns size do: [ :index | columns at: index put: (AFColumn number: index) ]
]

{ #category : #accessing }
AFChart >> last [
	^ columns last
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
