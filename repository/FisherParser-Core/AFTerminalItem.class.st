"
a terminal item.

"
Class {
	#name : #AFTerminalItem,
	#superclass : #AFItem,
	#instVars : [
		'terminal',
		'word'
	],
	#category : #'FisherParser-Core-Implementation'
}

{ #category : #accessing }
AFTerminalItem class >> given: aTerminal word: aWord startedAt: firstColumn [
	"
	a terminal item for the given terminal 
	that started its recognition at first column
	"

	^ self basicNew initializeTerminal: aTerminal word: aWord startedAt: firstColumn
]

{ #category : #comparing }
AFTerminalItem >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].
	self class == anObject class
		ifFalse: [ ^ false ].
	start = anObject start
		ifFalse: [ ^ false ].
	end = anObject end
		ifFalse: [ ^ false ].
	terminal = anObject terminal
		ifFalse: [ ^ false ].
	^ true
]

{ #category : #comparing }
AFTerminalItem >> equals: anItem [
	^ self class == anItem class
			and: [ start = anItem start 
				and: [ terminal = anItem terminal ] ]
]

{ #category : #printing }
AFTerminalItem >> gtDisplayOn: aStream [
	"[ terminal @ [ start, end ] ]"

	aStream nextPut: $[.
	terminal gtDisplayOn: aStream.
	aStream nextPutAll: ' @ '.
	self printIntervalOn: aStream.
	aStream nextPut: $]
]

{ #category : #'inspector extensions' }
AFTerminalItem >> gtDisplayValueString [
	^ String streamContents: [ :s | terminal gtDisplayOn: s ]
]

{ #category : #comparing }
AFTerminalItem >> hash [
	^ (terminal hash + (start hash + end hash) hashMultiply) hashMultiply
]

{ #category : #initialization }
AFTerminalItem >> initializeTerminal: aTerminalHypernotion word: aWord startedAt: aColumn [
	terminal := aTerminalHypernotion.
	word := aWord.
	start := aColumn.
	node := AFPackedNode model: self
]

{ #category : #parsing }
AFTerminalItem >> node [
	^ node
]

{ #category : #printing }
AFTerminalItem >> printOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPut: $(.
	terminal printOn: aStream.
	aStream nextPutAll: ' @ '.
	self printIntervalOn: aStream.
	aStream nextPut: $)
]

{ #category : #'initialize-release' }
AFTerminalItem >> release [
	terminal := nil.
	word := nil.
	super release
]

{ #category : #accessing }
AFTerminalItem >> terminal [
	^ terminal
]
