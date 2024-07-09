"
a dotted item
"
Class {
	#name : #AFDottedItem,
	#superclass : #AFItem,
	#instVars : [
		'dottedHyperRule'
	],
	#category : #'FisherParser-Core-Implementation'
}

{ #category : #'instance creation' }
AFDottedItem class >> of: aDottedHyperRule startAt: aColumn [
	^ self basicNew
		initializeDottedHyperRule: aDottedHyperRule start: aColumn;
		yourself
]

{ #category : #'instance creation' }
AFDottedItem class >> of: aDottedHyperRule startAt: firstColumn endAt: secondColumn [
	^ self basicNew
		initializeDottedHyperRule: aDottedHyperRule start: firstColumn;
		end: secondColumn;
		yourself
]

{ #category : #comparing }
AFDottedItem >> = anItem [
	self == anItem
		ifTrue: [ ^ true ].
	self class == anItem class
		ifFalse: [ ^ false ].
	start = anItem start
		ifFalse: [ ^ false ].
	dottedHyperRule = anItem dottedHyperRule
		ifFalse: [ ^ false ].
	end = anItem end
		ifFalse: [ ^ false ].
	^ true
]

{ #category : #parsing }
AFDottedItem >> addFamily: aFamily [
	self node addFamily: aFamily
]

{ #category : #parsing }
AFDottedItem >> addFamilyWith: completeItem [
	self node addFamily: (AFFamily with: completeItem node)
]

{ #category : #parsing }
AFDottedItem >> addFamilyWith: previousItem and: completeItem [
	self node addFamily: (AFFamily with: previousItem node with: completeItem node)
]

{ #category : #parsing }
AFDottedItem >> addFamilyWith: completeItem to: parentItem [
	^ self isPredicted
		ifTrue: [ parentItem addFamilyWith: completeItem ]
		ifFalse: [ parentItem addFamilyWith: self and: completeItem ]
]

{ #category : #parsing }
AFDottedItem >> asSyntaxNode [
	^ ESSyntaxNode
		symbol: self head
		reason: self rule asSubstitutionExpression
		start: start number
		end: end number
]

{ #category : #displaying }
AFDottedItem >> displayStringOn: aStream [

	"[ dotted hyper rule @ start ]"

	"[ dotted hyper rule @  [ start, end ] ]"

	aStream nextPut: $[.
	dottedHyperRule displayStringOn: aStream.
	aStream nextPutAll: ' @ '.
	self printIntervalOn: aStream.
	aStream nextPut: $]
]

{ #category : #accessing }
AFDottedItem >> dottedHyperRule [
	^ dottedHyperRule
]

{ #category : #comparing }
AFDottedItem >> equals: anItem [
	^ (super equals: anItem) and: [ dottedHyperRule isInstanceOf: anItem dottedHyperRule ]
]

{ #category : #parsing }
AFDottedItem >> families [
	^ self node families
]

{ #category : #parsing }
AFDottedItem >> familiesSize [
	^ self node familiesSize
]

{ #category : #enumerating }
AFDottedItem >> finalItemsWithHeadMatchSymbolAtDotDo: aBlock [
	end finalItemsWithHeadMatch: self symbolAtDot do: aBlock
]

{ #category : #comparing }
AFDottedItem >> hash [
	^ ((dottedHyperRule hash + start hash) hashMultiply + end hash) hashMultiply
]

{ #category : #accessing }
AFDottedItem >> head [
	^ dottedHyperRule head
]

{ #category : #initialization }
AFDottedItem >> initializeDottedHyperRule: aDottedHyperRule start: aColumn [
	node := nil.
	dottedHyperRule := aDottedHyperRule.
	start := aColumn
]

{ #category : #testing }
AFDottedItem >> isEpsilon [
	^ dottedHyperRule isEpsilon
]

{ #category : #testing }
AFDottedItem >> isFinal [
	^ dottedHyperRule isFinal
]

{ #category : #testing }
AFDottedItem >> isPredicted [
	^ dottedHyperRule isPredicted
]

{ #category : #testing }
AFDottedItem >> isTerminal [
	^ false
]

{ #category : #accessing }
AFDottedItem >> moveDotForward [
	^ self class of: dottedHyperRule moveDotForward startAt: start
]

{ #category : #accessing }
AFDottedItem >> moveDotForwardAfterApplying: aSubstitution [
	^ self class
		of: (dottedHyperRule moveDotForwardAfterApplying: aSubstitution)
		startAt: start
]

{ #category : #parsing }
AFDottedItem >> node [
	^ node
		ifNil: [ 
			node := AFPackedNode model: self.
			self isEpsilon ifTrue: [ node addEmptyFamily ].
			node ]
]

{ #category : #enumerating }
AFDottedItem >> predictionItemsDo: aBlock [
	start predictionItemsDo: aBlock
]

{ #category : #printing }
AFDottedItem >> printOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPut: $(.
	dottedHyperRule printOn: aStream.
	aStream nextPutAll: ' @ '.
	self printIntervalOn: aStream.
	aStream nextPut: $)
]

{ #category : #'initialize-release' }
AFDottedItem >> release [
	dottedHyperRule := nil.
	super release
]

{ #category : #accessing }
AFDottedItem >> rule [
	^ dottedHyperRule rule
]

{ #category : #accessing }
AFDottedItem >> symbolAtDot [
	^ dottedHyperRule symbolAtDot
]
