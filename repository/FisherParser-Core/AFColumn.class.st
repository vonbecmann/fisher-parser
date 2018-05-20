"
similar to earley's column.
"
Class {
	#name : #AFColumn,
	#superclass : #Object,
	#instVars : [
		'number',
		'items',
		'itemSet',
		'orderedItems'
	],
	#category : #'FisherParser-Core-Implementation'
}

{ #category : #'as yet unclassified' }
AFColumn class >> number: anInteger [
	^ self basicNew
		initializeNumber: anInteger;
		yourself
]

{ #category : #adding }
AFColumn >> add: anItem [
	itemSet
		like: anItem
		ifAbsent: [ 	items nextPut: anItem.
						itemSet add: anItem.
						orderedItems addLast: anItem.
						anItem
							end: self;
							yourself ]
]

{ #category : #'inspector extensions' }
AFColumn >> gtInspectorItemsIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ composite table
		title: [ orderedItems size asString , ' items' ];
		display: [ orderedItems asArray ];
		column: '@ [start, end]' evaluated: [ :each | each gtDisplayIntervalString ] width: 100;
		column: 'Value' evaluated: [ :each | each gtDisplayValueString ];
		showOnly: 50;
		yourself
]

{ #category : #testing }
AFColumn >> includes: anItem [
	^ itemSet includes: anItem
]

{ #category : #initialization }
AFColumn >> initialize [
	super initialize.
	items := SinglyLinkedQueue new.
	itemSet := Set new.
	orderedItems := SinglyLinkedList new
	
]

{ #category : #initialization }
AFColumn >> initializeNumber: anInteger [
	self initialize.
	number := anInteger
]

{ #category : #printing }
AFColumn >> printOn: aStream [
	"Column [number]"

	aStream
		nextPutAll: self className;
		nextPut: $[;
		print: number;
		nextPut: $]
]

{ #category : #printing }
AFColumn >> shortPrintOn: aStream [
	"number"

	number printOn: aStream
]
