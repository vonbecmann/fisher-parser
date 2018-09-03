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
AFColumn >> add: dottedItem [
	^ itemSet
		detect: [ :item | item equals: dottedItem ]
		ifFound: [ :item | item ]
		ifNone: [ self addDottedItem: dottedItem ]
]

{ #category : #adding }
AFColumn >> addDottedHyperRule: dottedHyperRule [
	itemSet
		detect: [ :item | item start = self and: [ item dottedHyperRule = dottedHyperRule ] ]
		ifNone: [ self addDottedItem: (dottedHyperRule startAt: self) ]
]

{ #category : #private }
AFColumn >> addDottedItem: dottedItem [
	itemsToProcess nextPut: dottedItem.
	itemSet addLast: dottedItem.
	dottedItem isFinal
		ifFalse: [ 
			dottedItem symbolAtDot isTerminal
				ifFalse: [ predictionItems addLast: dottedItem ] ].
	dottedItem end: self.
	^ orderedItems addLast: dottedItem
]

{ #category : #adding }
AFColumn >> addTerminalItem: aTerminalItem [
	^ itemSet
		detect: [ :item | item equals: aTerminalItem ]
		ifFound: [ :item | item ]
		ifNone: [ 
			aTerminalItem end: self.
			itemSet addLast: aTerminalItem.
			orderedItems addLast: aTerminalItem ]
]

{ #category : #'inspector extensions' }
AFColumn >> gtDisplayOn: aStream [
	"Column [number]"

	aStream
		nextPutAll: 'Column [';
		print: number;
		nextPut: $]
]

{ #category : #'inspector extensions' }
AFColumn >> gtInspectorOrderedItemsIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ composite table
		title: [ ' ordered items' ];
		display: [ orderedItems asArray ];
		column: '[start, end]' evaluated: [ :each | each gtDisplayIntervalString ] width: 70;
		column: 'Value' evaluated: [ :each | each gtDisplayValueString ];
		showOnly: 50;
		yourself
]

{ #category : #'inspector extensions' }
AFColumn >> gtInspectorPredictionItemsIn: composite [
	<gtInspectorPresentationOrder: 2>
	^ composite table
		title: [ 'Prediction' ];
		display: [ predictionItems asArray ];
		column: '[start, end]' evaluated: [ :each | each gtDisplayIntervalString ] width: 70;
		column: 'Value' evaluated: [ :each | each gtDisplayValueString ];
		showOnly: 50;
		yourself
]

{ #category : #'inspector extensions' }
AFColumn >> gtInspectorSortedItemsIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ composite table
		title: [ orderedItems size asString , ' sorted items' ];
		display: [ self sortedItems ];
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
	aStream
		nextPutAll: self className;
		nextPut: $(;
		print: number;
		nextPut: $)
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
	^ orderedItems size
]

{ #category : #'inspector extensions' }
AFColumn >> sortedItems [
	| sortedItems |
	sortedItems := SortedCollection new.
	sortedItems sortBlock: [ :a :b | a start <= b start ].
	sortedItems addAll: orderedItems.
	^ sortedItems
]
