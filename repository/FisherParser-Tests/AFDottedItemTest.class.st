Class {
	#name : #AFDottedItemTest,
	#superclass : #TestCase,
	#instVars : [
		'middleDot'
	],
	#category : #'FisherParser-Tests-Implementation'
}

{ #category : #initialization }
AFDottedItemTest >> setUp [
	middleDot := String with: (Character value: 183)
]

{ #category : #tests }
AFDottedItemTest >> testAsString [
	| item first |
	first := AFColumn number: 1.
	item := 
		(AFHyperRule 
			head: #('empty') asNotion 
			body: {}) dotAtBeginning startAt: first.

	self 
		assert: item asString 
		equals: '[empty: ' , middleDot, '. @ 1]'
]

{ #category : #tests }
AFDottedItemTest >> testAsString02 [
	| item first third |
	first := AFColumn number: 1.
	third := AFColumn number: 3.
	item := 
		(AFHyperRule 
			head: #('empty') asNotion 
			body: {}) dotAtBeginning startAt: first endAt: third.
	
	self 
		assert: item asString 
		equals: '[empty: ' , middleDot, '. @ [1, 3]]'
]

{ #category : #tests }
AFDottedItemTest >> testAsString03 [
	| item first third |
	first := AFColumn number: 1.
	third := AFColumn number: 3.
	item := 
	(AFHyperRule 
		head: #(#NOTION 'option') asNotion 
		body: {#(#NOTION) asNotion}) dotAtBeginning startAt: first endAt: third.
	
	self 
		assert: item asString 
		equals: '[NOTION option: ' , middleDot, 'NOTION. @ [1, 3]]'
]

{ #category : #tests }
AFDottedItemTest >> testAsString04 [
	| item first third |
	first := AFColumn number: 1.
	third := AFColumn number: 3.
	item := 
	(AFHyperRule 
		head: #(#NOTION 'option') asNotion 
		body: {#(#NOTION) asNotion}) dotAtEnd startAt: first endAt: third.
	
	self 
		assert: item asString 
		equals: '[NOTION option: NOTION', middleDot, '. @ [1, 3]]'
]

{ #category : #tests }
AFDottedItemTest >> testEqual [
	| first third one another |
	first := AFColumn number: 1.
	third := AFColumn number: 3.
	one := 
	(AFHyperRule 
		head: #(#NOTION 'option') asNotion 
		body: {#(#NOTION) asNotion}) dotAtEnd startAt: first endAt: third.
	another := 
		(AFHyperRule 
		head: #(#NOTION 'option') asNotion 
		body: {#(#NOTION) asNotion}) dotAtEnd startAt: first endAt: third.
		
	self deny: one == another.
	self assert: one equals: another.
	self assert: one hash equals: another hash.
]

{ #category : #tests }
AFDottedItemTest >> testEqual02 [
	| first third one another |
	first := AFColumn number: 1.
	third := AFColumn number: 3.
	one := 
	(AFHyperRule 
		head: #(#NOTION 'option') asNotion 
		body: {#(#NOTION) asNotion}) dotAtEnd startAt: first endAt: third.
	another := one.
		
	self assert: one == another.
	self assert: one equals: another.
	self assert: one hash equals: another hash.
]
