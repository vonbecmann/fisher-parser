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
AFTerminalItem >> equals: anItem [
	^ self class == anItem class
			and: [ start = anItem start 
				and: [ terminal = anItem terminal ] ]
]

{ #category : #'inspector extensions' }
AFTerminalItem >> gtDisplayOn: aStream [
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

{ #category : #initialization }
AFTerminalItem >> initializeTerminal: aTerminalHypernotion word: aWord startedAt: aColumn [
	terminal := aTerminalHypernotion.
	word := aWord.
	start := aColumn
]

{ #category : #accessing }
AFTerminalItem >> node [
	^ node ifNil: [ node := AFPackedNode model: self ]
]

{ #category : #printing }
AFTerminalItem >> printOn: aStream [
	"[ terminal @ [ start, end ] ]"

	aStream nextPut: $[.
	terminal printOn: aStream.
	aStream nextPutAll: ' @ '.
	self printIntervalOn: aStream.
	aStream nextPut: $]
]

{ #category : #'initialize-release' }
AFTerminalItem >> release [
	terminal := nil.
	word := nil.
	super release
]
