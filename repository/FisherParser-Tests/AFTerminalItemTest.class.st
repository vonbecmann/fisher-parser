Class {
	#name : #AFTerminalItemTest,
	#superclass : #TestCase,
	#category : #'FisherParser-Tests-Implementation'
}

{ #category : #tests }
AFTerminalItemTest >> testEquals [
	| one another |
	one := AFTerminalItem
		given: (NCTerminal character: $a)
		word: $a
		startedAt: (AFColumn number: 1).
	another := AFTerminalItem
		given: (NCTerminal character: $a)
		word: $a
		startedAt: (AFColumn number: 1).

	self assert: one equals: another.
	self assert: one hash equals: another hash
]
