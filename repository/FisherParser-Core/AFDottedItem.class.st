"
a dotted item
"
Class {
	#name : #AFDottedItem,
	#superclass : #Object,
	#instVars : [
		'dottedHyperRule',
		'start',
		'end'
	],
	#category : #'FisherParser-Core-Implementation'
}

{ #category : #'instance creation' }
AFDottedItem class >> of: aDottedHyperRule startAt: aColumn [
	^ self basicNew
		initializeDottedHyperRule: aDottedHyperRule start: aColumn;
		yourself
]

{ #category : #accessing }
AFDottedItem >> end: aColumn [ 
	end := aColumn
]

{ #category : #'inspector extensions' }
AFDottedItem >> gtDisplayIntervalString [
	^ String streamContents: [ :s | self printIntervalOn: s ]
]

{ #category : #'inspector extensions' }
AFDottedItem >> gtDisplayValueString [
	^ String streamContents: [ :s | dottedHyperRule printOn: s ]
]

{ #category : #initialization }
AFDottedItem >> initializeDottedHyperRule: aDottedHyperRule start: aColumn [
	self initialize.
	dottedHyperRule := aDottedHyperRule.
	start := aColumn
]

{ #category : #testing }
AFDottedItem >> isFinal [
	^ dottedHyperRule isFinal
]

{ #category : #accessing }
AFDottedItem >> moveDotForward [
	^ self class of: dottedHyperRule moveDotForward startAt: start
]

{ #category : #printing }
AFDottedItem >> printIntervalOn: aStream [
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
AFDottedItem >> printOn: aStream [
	"[ dotted hyper rule @ start ]"

	"[ dotted hyper rule @  [ start, end ] ]"

	aStream nextPut: $[.
	dottedHyperRule printOn: aStream.
	aStream nextPutAll: ' @ '.
	self printIntervalOn: aStream.
	aStream nextPut: $]
]

{ #category : #accessing }
AFDottedItem >> symbolAtDot [
	^ dottedHyperRule symbolAtDot
]
