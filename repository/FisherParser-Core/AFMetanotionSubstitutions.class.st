"
metanotion -> substitute.

"
Class {
	#name : 'AFMetanotionSubstitutions',
	#superclass : 'Object',
	#instVars : [
		'associations'
	],
	#category : 'FisherParser-Core-Matching',
	#package : 'FisherParser-Core',
	#tag : 'Matching'
}

{ #category : 'instance creation' }
AFMetanotionSubstitutions class >> empty [
	^ self new
]

{ #category : 'instance creation' }
AFMetanotionSubstitutions class >> with: anAssociation [
	^ self new
		add: anAssociation;
		yourself
]

{ #category : 'instance creation' }
AFMetanotionSubstitutions class >> withAll: anAssocCollection [
	^ self new
		addAll: anAssocCollection;
		yourself
]

{ #category : 'comparing' }
AFMetanotionSubstitutions >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].
	self class == anObject class
		ifFalse: [ ^ false ].
	self size == anObject size
		ifFalse: [ ^ false ].
	^ associations allSatisfy: [ :assoc | anObject includes: assoc ]
]

{ #category : 'adding' }
AFMetanotionSubstitutions >> add: anAssociation [
	" Metanotion -> Substitute "

	(associations includes: anAssociation)
		ifFalse: [ associations addLast: anAssociation ]
]

{ #category : 'adding' }
AFMetanotionSubstitutions >> addAll: anAssocCollection [
	anAssocCollection do: [ :assoc | self add: assoc ]
]

{ #category : 'accessing' }
AFMetanotionSubstitutions >> associations [
	^ associations
]

{ #category : 'accessing' }
AFMetanotionSubstitutions >> at: aMetanotion [

	associations do: [ :assoc |
		assoc key = aMetanotion ifTrue: [ ^ assoc value ] ].
	^ aMetanotion
]

{ #category : 'displaying' }
AFMetanotionSubstitutions >> displayStringOn: aStream [

	aStream nextPut: ${.
	associations
		do: [ :assoc | assoc displayStringOn: aStream ]
		separatedBy: [ aStream nextPutAll: ', ' ].
	aStream nextPut: $}
]

{ #category : 'comparing' }
AFMetanotionSubstitutions >> hash [
	^ (self class hash + self size hash) hashMultiply
]

{ #category : 'testing' }
AFMetanotionSubstitutions >> includes: anAssociation [
	^ associations includes: anAssociation
]

{ #category : 'testing' }
AFMetanotionSubstitutions >> includesMetanotion: aMetanotion [
	^ associations anySatisfy: [ :assoc | assoc key = aMetanotion ]
]

{ #category : 'initialization' }
AFMetanotionSubstitutions >> initialize [

	super initialize.
	associations := SinglyLinkedList new
]

{ #category : 'inspector extensions' }
AFMetanotionSubstitutions >> inspectionSubstitutionsIn: aBuilder [

	<inspectorPresentationOrder: 0 title: 'Subtitutions'>
	^ aBuilder newTable
		  items: associations asArray;
		  addColumn: (SpStringTableColumn
				   title: 'Metanotion'
				   evaluated: [ :each |
					   StObjectPrinter asTruncatedTextFrom: each key ]);
		  addColumn: (SpStringTableColumn
				   title: 'Substitute'
				   evaluated: [ :each |
					   StObjectPrinter asTruncatedTextFrom: each value ]);
		  yourself
]

{ #category : 'testing' }
AFMetanotionSubstitutions >> isEmpty [

	^ associations isEmpty
]

{ #category : 'printing' }
AFMetanotionSubstitutions >> printOn: aStream [

	aStream
		nextPutAll: self className;
		nextPut: $(.
	associations
		do: [ :assoc | aStream print: assoc ]
		separatedBy: [ aStream nextPutAll: ', ' ].
	aStream nextPut: $)
]

{ #category : 'accessing' }
AFMetanotionSubstitutions >> product: metanotionSubstitutionCollection [

	^ metanotionSubstitutionCollection isEmpty
		  ifTrue: [ { self } ]
		  ifFalse: [
				  | product |
				  product := SinglyLinkedList new.
				  metanotionSubstitutionCollection
					  collect: [ :metanotionSubstitution | self union: metanotionSubstitution ]
					  thenDo: [ :union | product add: union ].
				  product ]
]

{ #category : 'initialize-release' }
AFMetanotionSubstitutions >> release [
	associations := nil.
	super release
]

{ #category : 'accessing' }
AFMetanotionSubstitutions >> size [
	^ associations size
]

{ #category : 'accessing' }
AFMetanotionSubstitutions >> union: aMetanotionSubstitutions [
	^ self class new
		addAll: associations;
		addAll: aMetanotionSubstitutions associations;
		yourself
]

{ #category : 'testing' }
AFMetanotionSubstitutions >> uniquelyAssign: metanotions [
	" true if these substitutions uniquely assign each metanotion "

	self size == metanotions size
		ifFalse: [ ^ false ].
	^ metanotions allSatisfy: [ :metanotion | self includesMetanotion: metanotion ]
]
