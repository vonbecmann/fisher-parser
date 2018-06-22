"
a terminal hypernotion matcher.

"
Class {
	#name : #AFTerminalMatcher,
	#superclass : #Object,
	#instVars : [
		'terminal'
	],
	#category : #'FisherParser-Core-Matching'
}

{ #category : #'instance creation' }
AFTerminalMatcher class >> terminal: aTerminalHypernotion [
	^ self basicNew initializeTerminal: aTerminalHypernotion
]

{ #category : #initialization }
AFTerminalMatcher >> initializeTerminal: aTerminalHypernotion [ 
	terminal := aTerminalHypernotion 
]

{ #category : #public }
AFTerminalMatcher >> match: anObject [ 
	" a terminal hypernotion matches an object (i.e. a character) "
	^ terminal matches: anObject 
]

{ #category : #printing }
AFTerminalMatcher >> printOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPut: $(;
		print: terminal;
		nextPut: $)
]

{ #category : #printing }
AFTerminalMatcher >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]
