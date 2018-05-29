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

{ #category : #'instance creation' }
AFDottedItem class >> of: aDottedHyperRule startAt: firstColumn endAt: secondColumn [
	^ self basicNew
		initializeDottedHyperRule: aDottedHyperRule start: firstColumn;
		end: secondColumn;
		yourself
]

{ #category : #comparing }
AFDottedItem >> = anItem [
	self == anItem
		ifTrue: [ ^ true ].
	self class == anItem class
		ifFalse: [ ^ false ].
	start = anItem start
		ifFalse: [ ^ false ].
	dottedHyperRule = anItem dottedHyperRule
		ifFalse: [ ^ false ].
	end = anItem end
		ifFalse: [ ^ false ].
	^ true
]

{ #category : #accessing }
AFDottedItem >> dottedHyperRule [
	^ dottedHyperRule
]

{ #category : #accessing }
AFDottedItem >> end [
	^ end
]

{ #category : #accessing }
AFDottedItem >> end: aColumn [ 
	end := aColumn
]

{ #category : #comparing }
AFDottedItem >> equals: anItem [
	^ self class == anItem class
				and: [ start = anItem start 
								and: [ dottedHyperRule = anItem dottedHyperRule ] ]
]

{ #category : #'inspector extensions' }
AFDottedItem >> gtDisplayIntervalString [
	^ String streamContents: [ :s | self printIntervalOn: s ]
]

{ #category : #'inspector extensions' }
AFDottedItem >> gtDisplayValueString [
	^ String streamContents: [ :s | dottedHyperRule printOn: s ]
]

{ #category : #comparing }
AFDottedItem >> hash [
	^ ((dottedHyperRule hash + start hash) hashMultiply + end hash) hashMultiply
]

{ #category : #accessing }
AFDottedItem >> head [
	^ dottedHyperRule head
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

{ #category : #accessing }
AFDottedItem >> moveDotForwardAfterApplying: aSubstitution [
	^ self class
		of: (dottedHyperRule moveDotForwardAfterApplying: aSubstitution)
		startAt: start
]

{ #category : #accessing }
AFDottedItem >> predictionItems [
	^ start predictionItems
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

{ #category : #printing }
AFDottedItem >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]

{ #category : #'initialize-release' }
AFDottedItem >> release [
	dottedHyperRule := start := end := nil.
	super release
]

{ #category : #accessing }
AFDottedItem >> start [
	^ start
]

{ #category : #accessing }
AFDottedItem >> symbolAtDot [
	^ dottedHyperRule symbolAtDot
]
