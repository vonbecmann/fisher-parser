"
similar to earley's column.
"
Class {
	#name : #AFColumn,
	#superclass : #Object,
	#instVars : [
		'number',
		'itemSet',
		'orderedItems',
		'predictionItems',
		'itemsToProcess'
	],
	#category : #'FisherParser-Core-Implementation'
}

{ #category : #'instance creation' }
AFColumn class >> number: anInteger [
	^ self basicNew
		initializeNumber: anInteger;
		yourself
]

{ #category : #comparing }
AFColumn >> <= column [
	^ number <= column number
]

{ #category : #comparing }
AFColumn >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].
	^ self class == anObject class and: [ number == anObject number ]
]

{ #category : #adding }
AFColumn >> add: anItem [
	^ itemSet
		detect: [ :item | item equals: anItem ]
		ifFound: [ :item | item ]
		ifNone: [ self basicAdd: anItem ]
]

{ #category : #adding }
AFColumn >> addDottedHyperRule: dottedHyperRule [
	itemSet
		detect: [ :item | item start = self and: [ item dottedHyperRule = dottedHyperRule ] ]
		ifNone: [ self basicAdd: (dottedHyperRule startAt: self) ]
]

{ #category : #private }
AFColumn >> basicAdd: anItem [
	itemsToProcess nextPut: anItem.
	itemSet addLast: anItem.
	orderedItems addLast: anItem.
	anItem isFinal
		ifFalse: [ anItem symbolAtDot isTerminal
				ifFalse: [ predictionItems addLast: anItem ] ].
	^ anItem
		end: self;
		yourself
]

{ #category : #'inspector extensions' }
AFColumn >> gtInspectorItemsIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ composite table
		title: [ orderedItems size asString , ' items' ];
		display: [ self sortedItems ];
		column: '[start, end]' evaluated: [ :each | each gtDisplayIntervalString ] width: 70;
		column: 'Value' evaluated: [ :each | each gtDisplayValueString ];
		showOnly: 50;
		yourself
]

{ #category : #'inspector extensions' }
AFColumn >> gtInspectorPredictionItemsIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ composite table
		title: [ 'Prediction' ];
		display: [ predictionItems asArray ];
		column: '[start, end]' evaluated: [ :each | each gtDisplayIntervalString ] width: 70;
		column: 'Value' evaluated: [ :each | each gtDisplayValueString ];
		showOnly: 50;
		yourself
]

{ #category : #comparing }
AFColumn >> hash [
	^ number hash
]

{ #category : #testing }
AFColumn >> includes: anItem [
	^ itemSet 
		detect: [ :each | each equals: anItem ] 
		ifFound: [ true ] 
		ifNone: [ false ]
]

{ #category : #initialization }
AFColumn >> initialize [
	super initialize.
	itemsToProcess := SinglyLinkedQueue new.
	itemSet := SinglyLinkedList new.
	orderedItems := SinglyLinkedList new.
	predictionItems := SinglyLinkedList new
	
]

{ #category : #initialization }
AFColumn >> initializeNumber: anInteger [
	self initialize.
	number := anInteger
]

{ #category : #testing }
AFColumn >> isEmpty [
	^ orderedItems isEmpty
]

{ #category : #accessing }
AFColumn >> like: anItem ifFound: foundBlock ifNone: exceptionBlock [
	" Evaluate foundBlock if an item in the receiver that is equal to anItem, 
	  Evaluate exceptionBlock if no such item is found. "

	^ itemSet detect: [ :item | item equals: anItem ] ifFound: foundBlock ifNone: exceptionBlock
]

{ #category : #accessing }
AFColumn >> number [
	^ number
]

{ #category : #enumerating }
AFColumn >> predictionItemsDo: aBlock [
	predictionItems do: aBlock
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
AFColumn >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]

{ #category : #accessing }
AFColumn >> processItems: aBlock [
	"process each item in order"

	[ itemsToProcess isEmpty ] whileFalse: [ aBlock value: itemsToProcess next ]
]

{ #category : #'initialize-release' }
AFColumn >> release [
	number := itemsToProcess := itemSet := orderedItems := predictionItems := nil.
	super release
]

{ #category : #printing }
AFColumn >> shortPrintOn: aStream [
	"number"

	number printOn: aStream
]

{ #category : #accessing }
AFColumn >> size [
	^ itemSet size
]

{ #category : #'inspector extensions' }
AFColumn >> sortedItems [
	| sortedItems |
	sortedItems := SortedCollection new.
	sortedItems sortBlock: [ :a :b | a start <= b start ].
	sortedItems addAll: orderedItems.
	^ sortedItems
]
