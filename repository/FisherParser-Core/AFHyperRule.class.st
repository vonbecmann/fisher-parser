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
		'body'
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

{ #category : #testing }
AFHyperRule >> checkHypernotionsAreLLOne [
	head checkIsLLOne.
	body checkHypernotionsAreLLOne
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
AFHyperRule >> initializeHead: aHypernotion body: aHyperalternative [
	head := aHypernotion.
	body := aHyperalternative
]

{ #category : #testing }
AFHyperRule >> isEpsilon [
	^ body isEmpty
]

{ #category : #'testing - boundness' }
AFHyperRule >> isLRTypeIffForAll: metanotions [
	" A hyper rule is of the type LR if and only if(iif)
		it is both left-bound and right-bound. "

	^ (self isLeftBoundIffForAll: metanotions)
		and: [ self isRightBoundIffForAll: metanotions ]
]

{ #category : #'testing - boundness' }
AFHyperRule >> isLTypeIffForAll: metanotions [
	" A hyper rule is of the type L if and only if(iff)
		it is left-bound but not right-bound. "

	^ (self isLeftBoundIffForAll: metanotions)
		and: [ (self isRightBoundIffForAll: metanotions) not ]
]

{ #category : #'testing - boundness' }
AFHyperRule >> isLeftBoundIffForAll: metanotions [
	" left-bound if and only if(iff) for all m in metanotions:
		((head occurrencesOf: m) ~= 0) implies that ((body occurrencesOf: m) ~= 0) "

	metanotions
		do: [ :m | 
			(head occurrencesOf: m) ~= 0 ==> [ (body occurrencesOf: m) ~= 0 ]
				ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #'testing - boundness' }
AFHyperRule >> isRTypeIffForAll: metanotions [
	" A hyper rule is of the type R if and only if(iff)
		it is right-bound but not left-bound. "

	^ (self isRightBoundIffForAll: metanotions)
		and: [ (self isLeftBoundIffForAll: metanotions) not ]
]

{ #category : #testing }
AFHyperRule >> isRepresentation [
	"head is metanotion free and the body is a terminal"

	^ head isProtonotion and: [ body size = 1 and: [ body first isTerminal ] ]
]

{ #category : #'testing - boundness' }
AFHyperRule >> isRightBoundIffForAll: metanotions [
	" right-bound if and only if(iff) for all m in metanotions:
		((body occurrencesOf: m) ~= 0) implies that ((head occurrencesOf: m) ~= 0) "

	metanotions
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

	^ head isStrict and: [ body isStrict ]
]

{ #category : #'testing - boundness' }
AFHyperRule >> isXTypeIffForAll: metanotions [
	" A hyper rule is of the type X if and only if(iff)
		it is neither left-bound nor right-bound. "

	^ (self isLeftBoundIffForAll: metanotions) not
		and: [ (self isRightBoundIffForAll: metanotions) not ]
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
	head := body := nil.
	super release
]
