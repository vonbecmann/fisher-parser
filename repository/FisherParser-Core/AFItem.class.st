"
LR item.

"
Class {
	#name : #AFItem,
	#superclass : #Object,
	#instVars : [
		'start',
		'end',
		'node'
	],
	#category : #'FisherParser-Core-Implementation'
}

{ #category : #accessing }
AFItem >> end [
	^ end
]

{ #category : #accessing }
AFItem >> end: aColumn [ 
	end := aColumn
]

{ #category : #'inspector extensions' }
AFItem >> gtDisplayIntervalString [
	^ String streamContents: [ :s | self printIntervalOn: s ]
]

{ #category : #printing }
AFItem >> printIntervalOn: aStream [
	end
		ifNil: [ 	start shortPrintOn: aStream ]
		ifNotNil: [ 
			aStream nextPut: $[.
			start shortPrintOn: aStream.
			aStream nextPutAll: ', '.
			end shortPrintOn: aStream.
			aStream nextPut: $] ]
]

{ #category : #printing }
AFItem >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]

{ #category : #'initialize-release' }
AFItem >> release [
	start := end := node := nil.
	super release
]

{ #category : #accessing }
AFItem >> start [
	^ start
]
