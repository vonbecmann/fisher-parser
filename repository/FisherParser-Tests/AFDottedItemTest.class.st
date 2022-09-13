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
			headWith: 'empty' asNotion
			body: {}) dotAtBeginning startAt: first.

	self 
		assert: item asString  
		equals: 'AFDottedItem(empty: ' , middleDot, '. @ 1)'
]

{ #category : #tests }
AFDottedItemTest >> testAsString02 [
	| item first third |
	first := AFColumn number: 1.
	third := AFColumn number: 3.
	item := 
		(AFHyperRule 
			headWith: 'empty' asNotion 
			body: {}) dotAtBeginning startAt: first endAt: third.
	
	self 
		assert: item asString 
		equals: 'AFDottedItem(empty: ' , middleDot, '. @ [1, 3])'
]

{ #category : #tests }
AFDottedItemTest >> testAsString03 [
	| item first third |
	first := AFColumn number: 1.
	third := AFColumn number: 3.
	item := 
	(AFHyperRule 
		headWithAll: #(#NOTION 'option') asNotions
		bodyWith: (AFHypernotion with: #NOTION asNotion)) 
					dotAtBeginning startAt: first endAt: third.
	
	self 
		assert: item asString 
		equals: 'AFDottedItem(NOTIONoption: ' , middleDot, 'NOTION. @ [1, 3])'
]

{ #category : #tests }
AFDottedItemTest >> testAsString04 [
	| item first third |
	first := AFColumn number: 1.
	third := AFColumn number: 3.
	item := 
	(AFHyperRule 
		headWithAll: #(#NOTION 'option') asNotions
		bodyWith: (AFHypernotion with: #NOTION asNotion)) 
					dotAtEnd startAt: first endAt: third.
	
	self 
		assert: item asString 
		equals: 'AFDottedItem(NOTIONoption: NOTION', middleDot, '. @ [1, 3])'
]

{ #category : #tests }
AFDottedItemTest >> testEquals [
	| first third one another |
	first := AFColumn number: 1.
	third := AFColumn number: 3.
	one := 
	(AFHyperRule 
		headWithAll: #(#NOTION 'option') asNotions
		bodyWith: (AFHypernotion with: #NOTION asNotion)) 
					dotAtEnd startAt: first endAt: third.
	another := 
		(AFHyperRule 
			headWithAll: #(#NOTION 'option') asNotions
			bodyWith: (AFHypernotion with: #NOTION asNotion)) 
						dotAtEnd startAt: first endAt: third.
		
	self deny: one == another.
	self assert: one equals: another.
	self assert: one hash equals: another hash.
	self assert: another equals: one.
	self assert: another hash equals: one hash
]

{ #category : #tests }
AFDottedItemTest >> testEquals02 [
	| first third one another |
	first := AFColumn number: 1.
	third := AFColumn number: 3.
	one := 
	(AFHyperRule 
		headWithAll: #(#NOTION 'option') asNotions 
		bodyWith: (AFHypernotion with: #NOTION asNotion)) 
			dotAtEnd startAt: first endAt: third.
	another := one.
		
	self assert: one == another.
	self assert: one equals: another.
	self assert: one hash equals: another hash.
	self assert: another equals: one.
	self assert: another hash equals: one hash
]

{ #category : #tests }
AFDottedItemTest >> testGtDisplayString [

	| item first |
	first := AFColumn number: 1.
	item := (AFHyperRule headWith: 'empty' asNotion body: {  })
		        dotAtBeginning startAt: first.

	self
		assert: item displayString
		equals: '[empty: ' , middleDot , '. @ 1]'
]

{ #category : #tests }
AFDottedItemTest >> testGtDisplayString02 [

	| item first third |
	first := AFColumn number: 1.
	third := AFColumn number: 3.
	item := (AFHyperRule headWith: 'empty' asNotion body: {  })
		        dotAtBeginning startAt: first endAt: third.

	self
		assert: item displayString
		equals: '[empty: ' , middleDot , '. @ [1, 3]]'
]

{ #category : #tests }
AFDottedItemTest >> testGtDisplayString03 [

	| item first third |
	first := AFColumn number: 1.
	third := AFColumn number: 3.
	item := (AFHyperRule
		         headWithAll: #( #NOTION 'option' ) asNotions
		         bodyWith: (AFHypernotion with: #NOTION asNotion))
		        dotAtBeginning startAt: first endAt: third.

	self
		assert: item displayString
		equals: '[NOTION option: ' , middleDot , 'NOTION. @ [1, 3]]'
]

{ #category : #tests }
AFDottedItemTest >> testGtDisplayString04 [

	| item first third |
	first := AFColumn number: 1.
	third := AFColumn number: 3.
	item := (AFHyperRule
		         headWithAll: #( #NOTION 'option' ) asNotions
		         bodyWith: (AFHypernotion with: #NOTION asNotion)) dotAtEnd
		        startAt: first
		        endAt: third.

	self
		assert: item displayString
		equals: '[NOTION option: NOTION' , middleDot , '. @ [1, 3]]'
]
