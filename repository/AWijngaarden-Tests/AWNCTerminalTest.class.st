Class {
	#name : #AWNCTerminalTest,
	#superclass : #TestCase,
	#category : #'AWijngaarden-Tests'
}

{ #category : #tests }
AWNCTerminalTest >> testIsMetanotion [
	self deny: (NCTerminal character: $A) isMetanotion
]

{ #category : #tests }
AWNCTerminalTest >> testIsProtonotion [
	self deny: (NCTerminal character: $A) isProtonotion
]
