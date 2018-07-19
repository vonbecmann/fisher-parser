"
a hyper rule used by the algorithm.

allows
	- to create a dotted hyper rule of myself.
	- to substitute metanotions and result on another hyper rule

"
Class {
	#name : #AFHyperRule,
	#superclass : #Object,
	#instVars : [
		'head',
		'body',
		'metanotions'
	],
	#category : #'FisherParser-Core-Implementation'
}

{ #category : #'instance creation' }
AFHyperRule class >> head: anAFHypernotion body: anAFHypernotionCollection [
	^ self basicNew
		initializeHead: anAFHypernotion body: (AFHyperAlternative withAll: anAFHypernotionCollection);
		yourself
]

{ #category : #'instance creation' }
AFHyperRule class >> head: firstAFHypernotion bodyWith: secondAFHypernotion [
	^ self basicNew
		initializeHead: firstAFHypernotion body: (AFHyperAlternative with: secondAFHypernotion);
		yourself
]

{ #category : #'instance creation' }
AFHyperRule class >> headWith: aNotion body: anAFHypernotionCollection [
	^ self basicNew
		initializeHead: (AFHypernotion with: aNotion) body: (AFHyperAlternative withAll: anAFHypernotionCollection);
		yourself
]

{ #category : #'instance creation' }
AFHyperRule class >> headWith: aNotion bodyWith: anAFHypernotion [
	^ self basicNew
		initializeHead: (AFHypernotion with: aNotion) body: (AFHyperAlternative with: anAFHypernotion);
		yourself
]

{ #category : #'instance creation' }
AFHyperRule class >> headWithAll: aNotionCollection body: anAFHypernotionCollection [
	^ self basicNew
		initializeHead: (AFHypernotion withAll: aNotionCollection) body: (AFHyperAlternative withAll: anAFHypernotionCollection);
		yourself
]

{ #category : #'instance creation' }
AFHyperRule class >> headWithAll: aNotionCollection bodyWith: anAFHypernotion [
	^ self basicNew
		initializeHead: (AFHypernotion withAll: aNotionCollection) body: (AFHyperAlternative with: anAFHypernotion);
		yourself
]

{ #category : #comparing }
AFHyperRule >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].
	self class == anObject class
		ifFalse: [ ^ false ].
	head = anObject head
		ifFalse: [ ^ false ].
	body = anObject body
		ifFalse: [ ^ false ].
	^ true
]

{ #category : #accessing }
AFHyperRule >> apply: aSubstitution [
	^ self class head: (head apply: aSubstitution) body: (body apply: aSubstitution)
]

{ #category : #accessing }
AFHyperRule >> body [
	^ body
]

{ #category : #accessing }
AFHyperRule >> dotAtBeginning [
	^ AFDottedHyperRule atTheBeginningOf: self
]

{ #category : #accessing }
AFHyperRule >> dotAtEnd [
	^ AFDottedHyperRule atTheEndOf: self
]

{ #category : #'inspector extensions' }
AFHyperRule >> gtDisplayOn: aStream [
	head gtDisplayOn: aStream.
	aStream nextPutAll: ': '.
	body gtDisplayOn: aStream.
	aStream nextPut: $.
]

{ #category : #comparing }
AFHyperRule >> hash [
	^ ((head hash + body hash) hashMultiply + self class hash) hashMultiply
]

{ #category : #accessing }
AFHyperRule >> head [
	^ head
]

{ #category : #initialization }
AFHyperRule >> initialize [
	metanotions := Set new
]

{ #category : #initialization }
AFHyperRule >> initializeHead: aHypernotion body: aHyperalternative [
	self initialize.
	head := aHypernotion.
	body := aHyperalternative.
	metanotions
		addAll: head metanotions;
		addAll: body metanotions
]

{ #category : #testing }
AFHyperRule >> isEpsilon [
	^ body isEmpty
]

{ #category : #'testing - boundness' }
AFHyperRule >> isLRType [
	" A hyper rule is of the type LR iif it is both left-bound and right-bound. "

	^ self isLeftBound and: [ self isRightBound ]
]

{ #category : #'testing - boundness' }
AFHyperRule >> isLTypeIffForAll: aMetanotionCollection [
	" A hyper rule is of the type L if and only if(iff)
		it is left-bound but not right-bound. "

	^ (self isLeftBoundIffForAll: aMetanotionCollection)
		and: [ (self isRightBoundIffForAll: aMetanotionCollection) not ]
]

{ #category : #'testing - boundness' }
AFHyperRule >> isLeftBound [
	" left-bound if for all M in metanotions:
		((head occurrencesOf: M) ~= 0) implies that ((body occurrencesOf: M) ~= 0) "

	^ metanotions isEmpty
		ifTrue: [ false ]
		ifFalse: [ 
			metanotions
				do: [ :m | 
					(head occurrencesOf: m) ~= 0 ==> [ (body occurrencesOf: m) ~= 0 ]
						ifFalse: [ ^ false ] ].
			true ]
]

{ #category : #'testing - boundness' }
AFHyperRule >> isLeftBoundIffForAll: aMetanotionCollection [
	" left-bound if and only if(iff) for all m in metanotions:
		((head occurrencesOf: m) ~= 0) implies that ((body occurrencesOf: m) ~= 0) "

	aMetanotionCollection
		do: [ :m | 
			(head occurrencesOf: m) ~= 0 ==> [ (body occurrencesOf: m) ~= 0 ]
				ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #'testing - boundness' }
AFHyperRule >> isRType [
	" A hyper rule is of the type R iif it is right-bound but not left-bound. "

	^ self isRightBound and: [ self isLeftBound not ]
]

{ #category : #testing }
AFHyperRule >> isRepresentation [
	"head is metanotion free and the body is a terminal"

	^ head isProtonotion and: [ body size = 1 and: [ body first isTerminal ] ]
]

{ #category : #'testing - boundness' }
AFHyperRule >> isRightBound [
	" right-bound if for all M in metanotions:
		((body occurrencesOf: M) ~= 0) implies that ((head occurrencesOf: M) ~= 0) "

	^ metanotions isEmpty
		ifTrue: [ false ]
		ifFalse: [ 
			metanotions
				do: [ :m | 
					((body occurrencesOf: m) ~= 0) ==> [ (head occurrencesOf: m) ~= 0 ]
						ifFalse: [ ^ false ] ].
			true ]
]

{ #category : #'testing - boundness' }
AFHyperRule >> isRightBoundIffForAll: aMetanotionCollection [
	" right-bound if and only if(iff) for all m in metanotions:
		((body occurrencesOf: m) ~= 0) implies that ((head occurrencesOf: m) ~= 0) "

	aMetanotionCollection
		do: [ :m | 
			(body occurrencesOf: m) ~= 0 ==> [ (head occurrencesOf: m) ~= 0 ]
				ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #testing }
AFHyperRule >> isStrict [
	" if this hyper rule is a production rule that belongs to the strict language.
	it has 
	- notions (nonterminals, for which a production rule can be derived)
	- a symbol (a terminal symbol)
	- empty, or
	- some other protonotion (for which no production rule can be derived),
		which is then said to be a 'blind alley'. "

	^ metanotions isEmpty
]

{ #category : #'testing - boundness' }
AFHyperRule >> isXTypeIffForAll: aMetanotionCollection [
	" A hyper rule is of the type X if and only if(iff)
		it is neither left-bound nor right-bound. "

	^ (self isLeftBoundIffForAll: aMetanotionCollection) not
		and: [ (self isRightBoundIffForAll: aMetanotionCollection) not ]
]

{ #category : #printing }
AFHyperRule >> printOn: aStream [
	aStream
		print: head;
		nextPutAll: ': ';
		print: body;
		nextPut: $.
]

{ #category : #printing }
AFHyperRule >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]

{ #category : #'initialize-release' }
AFHyperRule >> release [
	head := body := metanotions := nil.
	super release
]
