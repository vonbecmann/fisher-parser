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

{ #category : #'instance creation' }
AFColumn class >> number: anInteger [
	^ self basicNew
		initializeNumber: anInteger;
		yourself
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
		detect: 	[ :item | item = anItem ]
		ifFound: 	[ :item | item ]
		ifNone: 
			[	items nextPut: anItem.
				itemSet addLast: anItem.
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

{ #category : #comparing }
AFColumn >> hash [
	^ number hash
]

{ #category : #testing }
AFColumn >> includes: anItem [
	^ itemSet includes: anItem
]

{ #category : #initialization }
AFColumn >> initialize [
	super initialize.
	items := SinglyLinkedQueue new.
	itemSet := SinglyLinkedList new.
	orderedItems := SinglyLinkedList new
	
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
AFColumn >> number [
	^ number
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

	[ items isEmpty ] whileFalse: [ aBlock value: items next ]
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
