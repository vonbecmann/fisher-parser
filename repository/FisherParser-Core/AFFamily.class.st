"
a family of packed parse nodes.
"
Class {
	#name : #AFFamily,
	#superclass : #Object,
	#instVars : [
		'parent',
		'first',
		'second'
	],
	#category : #'FisherParser-Core-BSPPForest'
}

{ #category : #'instance creation' }
AFFamily class >> empty [
	^ self basicNew initializeFirst: nil andSecond: nil
]

{ #category : #'instance creation' }
AFFamily class >> with: aPackedNode [
	^ self basicNew initializeFirst: aPackedNode andSecond: nil
]

{ #category : #'instance creation' }
AFFamily class >> with: firstPackedNode with: secondPackedNode [
	^ self basicNew initializeFirst: firstPackedNode andSecond: secondPackedNode
]

{ #category : #comparing }
AFFamily >> = anObject [
	^ self class == anObject class
		and: [ parent == anObject parent
				and: [ first == anObject first 
					and: [ second == anObject second ] ] ]
]

{ #category : #visiting }
AFFamily >> acceptPostOrderVisitor: aVisitor [
	aVisitor visitPostOrderFamily: self
]

{ #category : #visiting }
AFFamily >> acceptPreOrderVisitor: aVisitor [
	aVisitor visitPreOrderFamily: self
]

{ #category : #visiting }
AFFamily >> acceptVisitor: aVisitor [
	aVisitor visitNode: self
]

{ #category : #visiting }
AFFamily >> children [
	^ self members
]

{ #category : #displaying }
AFFamily >> displayStringOn: aStream [

	aStream nextPut: $(.
	first ifNotNil: [ 
		first displayStringOn: aStream.
		second ifNotNil: [ 
			aStream nextPutAll: ', '.
			second displayStringOn: aStream ] ].
	aStream nextPut: $)
]

{ #category : #accessing }
AFFamily >> first [
	^ first
]

{ #category : #'inspector extensions' }
AFFamily >> gtInspectorBrowserIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ composite tree
		title: 'Browse';
		display: [ self ];
		children: [ :each | each children ];
		format: [ :each | GTObjectPrinter asTruncatedTextFrom: each ];
		yourself
]

{ #category : #comparing }
AFFamily >> hash [
	| hash |
	hash := (self class hash + parent identityHash) hashMultiply.
	first
		ifNotNil: 
			[	hash := (hash + first identityHash) hashMultiply.
				second ifNotNil: [ hash := (hash + second identityHash) hashMultiply ] ].
	^ hash
]

{ #category : #initialization }
AFFamily >> initializeFirst: firstPackedNode andSecond: secondPackedNode [
	first := firstPackedNode.
	second := secondPackedNode
]

{ #category : #testing }
AFFamily >> isEmpty [
	^ first isNil and: [ second isNil ]
]

{ #category : #accessing }
AFFamily >> members [
	^ first
		ifNil: [ #() ]
		ifNotNil: [ 
			second
				ifNil: [ {first} ]
				ifNotNil: [ {first. second} ] ]
]

{ #category : #accessing }
AFFamily >> parent [
	^ parent
]

{ #category : #initialization }
AFFamily >> parent: aPackedNode [
	parent := aPackedNode
]

{ #category : #printing }
AFFamily >> printOn: aStream [
	aStream 
		nextPutAll: self className;
		nextPut: $(.
	first
		ifNotNil: [ 
			aStream print: first.
			second
				ifNotNil: [ 
					aStream
						nextPutAll: ', ';
						print: second ] ].
	aStream nextPut: $)
]

{ #category : #printing }
AFFamily >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]

{ #category : #'initialize-release' }
AFFamily >> release [
	parent := first := second := nil.
	super release
]

{ #category : #accessing }
AFFamily >> second [
	^ second
]

{ #category : #accessing }
AFFamily >> size [
	^ first 
		ifNil: [ 0 ] 
		ifNotNil: [ 
			second 
				ifNil: [ 1 ] 
				ifNotNil: [ 2 ] ]
]
