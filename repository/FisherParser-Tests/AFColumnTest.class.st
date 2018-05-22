Class {
	#name : #AFColumnTest,
	#superclass : #TestCase,
	#category : #'FisherParser-Tests-Implementation'
}

{ #category : #tests }
AFColumnTest >> testAsString [
	| one |
	one := AFColumn number: 1.
	
	self assert: one asString equals: 'AFColumn[1]'
]

{ #category : #tests }
AFColumnTest >> testEqual [
	| one another |
	one := AFColumn number: 1.
	another := AFColumn number: 1.
	
	self deny: one == another.
	self assert: one equals: another.
	self assert: one hash equals: another hash
]

{ #category : #tests }
AFColumnTest >> testEqual02 [
	| one another |
	one := AFColumn number: 1.
	another := one.
	
	self assert: one == another.
	self assert: one equals: another.
	self assert: one hash equals: another hash
]
