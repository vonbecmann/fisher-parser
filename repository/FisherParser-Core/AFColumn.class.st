"
similar to earley's column.
"
Class {
	#name : 'AFColumn',
	#superclass : 'Object',
	#instVars : [
		'number',
		'itemSet',
		'orderedItems',
		'predictionItems',
		'itemsToProcess',
		'finalItems'
	],
	#category : 'FisherParser-Core-Implementation',
	#package : 'FisherParser-Core',
	#tag : 'Implementation'
}

{ #category : 'instance creation' }
AFColumn class >> number: anInteger [
	^ self basicNew
		initializeNumber: anInteger;
		yourself
]

{ #category : 'instance creation' }
AFColumn class >> numberOneWithDottedHyperRule: aDottedHyperRule [
	^ (self number: 1)
		addDottedHyperRule: aDottedHyperRule;
		yourself
]

{ #category : 'comparing' }
AFColumn >> <= column [
	^ number <= column number
]

{ #category : 'comparing' }
AFColumn >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].
	^ self class == anObject class and: [ number == anObject number ]
]

{ #category : 'adding' }
AFColumn >> add: dottedItem [
	^ itemSet
		detect: [ :item | item equals: dottedItem ]
		ifFound: [ :item | item ]
		ifNone: [ self addDottedItem: dottedItem ]
]

{ #category : 'adding' }
AFColumn >> addDottedHyperRule: dottedHyperRule [
	itemSet
		detect: [ :item | item start = self and: [ item dottedHyperRule = dottedHyperRule ] ]
		ifNone: [ self addDottedItem: (dottedHyperRule startAt: self) ]
]

{ #category : 'private' }
AFColumn >> addDottedItem: dottedItem [

	itemsToProcess nextPut: dottedItem.
	itemSet addLast: dottedItem.
	dottedItem isFinal
		ifTrue: [
		dottedItem start = self ifTrue: [ finalItems addLast: dottedItem ] ]
		ifFalse: [
				dottedItem symbolAtDot isTerminal ifFalse: [
					predictionItems addLast: dottedItem ] ].
	dottedItem end: self.
	^ orderedItems addLast: dottedItem
]

{ #category : 'adding' }
AFColumn >> addTerminalItem: aTerminalItem [

	^ itemSet
		  detect: [ :item | item equals: aTerminalItem ]
		  ifFound: [ :item | item ]
		  ifNone: [
				  aTerminalItem end: self.
				  itemSet addLast: aTerminalItem.
				  orderedItems addLast: aTerminalItem ]
]

{ #category : 'displaying' }
AFColumn >> displayStringOn: aStream [

	"Column [number]"

	aStream
		nextPutAll: 'Column [';
		print: number;
		nextPut: $]
]

{ #category : 'enumerating' }
AFColumn >> finalItemsWithHeadMatch: aProtonotionHypernotion do: aBlock [

	finalItems do: [ :finalItem |
			finalItem head
				match: aProtonotionHypernotion
				do: [ aBlock value: finalItem ] ]
]

{ #category : 'comparing' }
AFColumn >> hash [
	^ number hash
]

{ #category : 'testing' }
AFColumn >> ifEmpty: aBlock [
	"Evaluate the given block, answering its value if the receiver is empty, otherwise answer the receiver."

	^ self isEmpty
		ifTrue: [ aBlock value ]
		ifFalse: [ self ]
]

{ #category : 'testing' }
AFColumn >> includesInstanceOf: anItem [

	^ itemSet
		  detect: [ :each | each isInstanceOf: anItem ]
		  ifFound: [ true ]
		  ifNone: [ false ]
]

{ #category : 'initialization' }
AFColumn >> initialize [

	super initialize.
	itemsToProcess := SinglyLinkedQueue new.
	itemSet := SinglyLinkedList new.
	orderedItems := SinglyLinkedList new.
	predictionItems := SinglyLinkedList new.
	finalItems := SinglyLinkedList new
]

{ #category : 'initialization' }
AFColumn >> initializeNumber: anInteger [
	self initialize.
	number := anInteger
]

{ #category : 'inspector extensions' }
AFColumn >> inspectionFinalItemsIn: aBuilder [

	<inspectorPresentationOrder: 3 title: 'Final'>
	^ aBuilder newList
		  display: [ :each | StObjectPrinter asTruncatedTextFrom: each ];
		  items: finalItems asArray;
		  yourself
]

{ #category : 'inspector extensions' }
AFColumn >> inspectionOrderedItemsIn: builder [

	<inspectorPresentationOrder: 1 title: 'ordered items'>
	^ builder newTable
		  addColumn: (SpStringTableColumn new
				   title: '[start, end]';
				   evaluated: [ :each | each displayIntervalString ];
				   width: 70;
				   yourself);
		  addColumn: (SpStringTableColumn
				   title: 'Value'
				   evaluated: [ :each | each displayString ]);
		  items: orderedItems asArray;
		  yourself
]

{ #category : 'inspector extensions' }
AFColumn >> inspectionPredictionItemsIn: aBuilder [

	<inspectorPresentationOrder: 2 title: 'Prediction'>
	^ aBuilder newTable
		  addColumn: (SpStringTableColumn new
				   title: '[start, end]';
				   evaluated: [ :each | each displayIntervalString ];
				   width: 70;
				   yourself);
		  addColumn: (SpStringTableColumn
				   title: 'Value'
				   evaluated: [ :each | each displayString ]);
		  items: predictionItems asArray;
		  yourself
]

{ #category : 'inspector extensions' }
AFColumn >> inspectionSortedItemsIn: aBuilder [

	<inspectorPresentationOrder: 0 title: 'Sorted'>
	^ aBuilder newTable
		  addColumn: (SpStringTableColumn new
				   title: '[start, end]';
				   evaluated: [ :each | each displayIntervalString ];
				   width: 70;
				   yourself);
		  addColumn: (SpStringTableColumn
				   title: 'Value'
				   evaluated: [ :each | each displayString ]);
		  items: self sortedItems;
		  yourself
]

{ #category : 'testing' }
AFColumn >> isEmpty [
	^ orderedItems isEmpty
]

{ #category : 'accessing' }
AFColumn >> like: anItem ifFound: foundBlock ifNone: exceptionBlock [
	" Evaluate foundBlock if an item in the receiver that is equal to anItem, 
	  Evaluate exceptionBlock if no such item is found. "

	^ itemSet
		  detect: [ :item | item equals: anItem ]
		  ifFound: foundBlock
		  ifNone: exceptionBlock
]

{ #category : 'accessing' }
AFColumn >> number [
	^ number
]

{ #category : 'enumerating' }
AFColumn >> predictionItemsDo: aBlock [
	predictionItems do: aBlock
]

{ #category : 'printing' }
AFColumn >> printOn: aStream [
	aStream
		nextPutAll: self className;
		nextPut: $(;
		print: number;
		nextPut: $)
]

{ #category : 'printing' }
AFColumn >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]

{ #category : 'accessing' }
AFColumn >> processItems: aBlock [
	"process each item in order"

	[ itemsToProcess isEmpty ] whileFalse: [ aBlock value: itemsToProcess next ]
]

{ #category : 'initialize-release' }
AFColumn >> release [
	number := itemsToProcess := itemSet := orderedItems := predictionItems := nil.
	finalItems := nil.
	super release
]

{ #category : 'printing' }
AFColumn >> shortPrintOn: aStream [
	"number"

	number printOn: aStream
]

{ #category : 'accessing' }
AFColumn >> size [
	^ orderedItems size
]

{ #category : 'inspector extensions' }
AFColumn >> sortedItems [
	| sortedItems |
	sortedItems := SortedCollection new.
	sortedItems sortBlock: [ :a :b | a start <= b start ].
	sortedItems addAll: orderedItems.
	^ sortedItems
]
