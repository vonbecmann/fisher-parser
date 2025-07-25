"
a hyper rule used by the algorithm.

allows
	- to create a dotted hyper rule of myself.
	- to substitute metanotions and result on another hyper rule

this hyper rule is the result of applying a substitution to a hyper rule.
self = instanceOfHyperRule apply: appliedSubstitution 
"
Class {
	#name : 'AFHyperRule',
	#superclass : 'Object',
	#instVars : [
		'head',
		'body',
		'instanceOfHyperRule',
		'appliedSubstitution'
	],
	#category : 'FisherParser-Core-Implementation',
	#package : 'FisherParser-Core',
	#tag : 'Implementation'
}

{ #category : 'instance creation' }
AFHyperRule class >> head: anAFHypernotion body: anAFHypernotionCollection instanceOf: anAWHyperRule [
	^ self basicNew
		initializeHead: anAFHypernotion body: (AFHyperAlternative withAll: anAFHypernotionCollection);
		instanceOf: anAWHyperRule appliedSubstitution: AFSubstitution emptySolution;
		yourself
]

{ #category : 'instance creation' }
AFHyperRule class >> head: anAFHypernotion body: anAFHyperAlternative instanceOf: anAWHyperRule applied: aSubstitution [
	^ self basicNew
		initializeHead: anAFHypernotion body: anAFHyperAlternative;
		instanceOf: anAWHyperRule appliedSubstitution: aSubstitution;
		yourself
]

{ #category : 'instance creation' }
AFHyperRule class >> head: firstAFHypernotion bodyWith: secondAFHypernotion [
	^ self basicNew
		initializeHead: firstAFHypernotion body: (AFHyperAlternative with: secondAFHypernotion);
		yourself
]

{ #category : 'instance creation' }
AFHyperRule class >> headWith: aNotion body: anAFHypernotionCollection [
	^ self basicNew
		initializeHead: (AFHypernotion with: aNotion) body: (AFHyperAlternative withAll: anAFHypernotionCollection);
		yourself
]

{ #category : 'instance creation' }
AFHyperRule class >> headWith: aNotion bodyWith: anAFHypernotion [
	^ self basicNew
		initializeHead: (AFHypernotion with: aNotion) body: (AFHyperAlternative with: anAFHypernotion);
		yourself
]

{ #category : 'instance creation' }
AFHyperRule class >> headWithAll: aNotionCollection body: anAFHypernotionCollection [
	^ self basicNew
		initializeHead: (AFHypernotion withAll: aNotionCollection) body: (AFHyperAlternative withAll: anAFHypernotionCollection);
		yourself
]

{ #category : 'instance creation' }
AFHyperRule class >> headWithAll: aNotionCollection bodyWith: anAFHypernotion [
	^ self basicNew
		initializeHead: (AFHypernotion withAll: aNotionCollection) body: (AFHyperAlternative with: anAFHypernotion);
		yourself
]

{ #category : 'comparing' }
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

{ #category : 'accessing' }
AFHyperRule >> apply: aSubstitution [
	^ self class
		head: (head apply: aSubstitution)
		body: (body apply: aSubstitution)
		instanceOf: instanceOfHyperRule
		applied: (appliedSubstitution union: aSubstitution)
]

{ #category : 'parsing' }
AFHyperRule >> asSubstitutionExpression [
	"this hyper rule is the result of applying a substitution to the grammar's hyper rule"

	^ OrderedPair first: instanceOfHyperRule second: appliedSubstitution
]

{ #category : 'accessing' }
AFHyperRule >> body [
	^ body
]

{ #category : 'displaying' }
AFHyperRule >> displayStringOn: aStream [

	head displayStringOn: aStream.
	aStream nextPutAll: ': '.
	body displayStringOn: aStream.
	aStream nextPutAll: '. '.
	appliedSubstitution displaySubstitutionStringOn: aStream
]

{ #category : 'displaying' }
AFHyperRule >> displaySubstitutionStringOn: aStream [

	appliedSubstitution displaySubstitutionStringOn: aStream
]

{ #category : 'accessing' }
AFHyperRule >> dotAtBeginning [
	^ AFDottedHyperRule atTheBeginningOf: self
]

{ #category : 'accessing' }
AFHyperRule >> dotAtEnd [
	^ AFDottedHyperRule atTheEndOf: self
]

{ #category : 'comparing' }
AFHyperRule >> hash [
	^ ((head hash + body hash) hashMultiply + self class hash) hashMultiply
]

{ #category : 'accessing' }
AFHyperRule >> head [
	^ head
]

{ #category : 'initialization' }
AFHyperRule >> initializeHead: aHypernotion body: aHyperalternative [
	head := aHypernotion.
	body := aHyperalternative.
	instanceOfHyperRule := self.
	appliedSubstitution := AFSubstitution emptySolution
]

{ #category : 'inspector extensions' }
AFHyperRule >> inspectionDisplayIn: aBuilder [

	<inspectorPresentationOrder: 0 title: 'Display'>
	^ aBuilder newText
		  text: self displayString;
		  yourself
]

{ #category : 'initialization' }
AFHyperRule >> instanceOf: anAWHyperRule appliedSubstitution: aSubstitution [
	instanceOfHyperRule := anAWHyperRule.
	appliedSubstitution := aSubstitution
]

{ #category : 'accessing' }
AFHyperRule >> instanceOfHyperRule [
	^ instanceOfHyperRule
]

{ #category : 'testing' }
AFHyperRule >> isEpsilon [
	^ body isEmpty
]

{ #category : 'testing' }
AFHyperRule >> isInstanceOf: anAFHyperRule [

	^ instanceOfHyperRule = anAFHyperRule instanceOfHyperRule
]

{ #category : 'testing - boundness' }
AFHyperRule >> isLRType [
	" A hyper rule is of the type LR if and only if(iif)
		it is both left-bound and right-bound. "

	^ self isLeftBound and: [ self isRightBound ]
]

{ #category : 'testing - boundness' }
AFHyperRule >> isLType [
	" A hyper rule is of the type L if and only if(iff)
		it is left-bound but not right-bound. "

	^ self isLeftBound and: [ self isRightBound not ]
]

{ #category : 'testing - boundness' }
AFHyperRule >> isLeftBound [
	" left-bound if and only if(iff) for all m in metanotions:
		((head occurrencesOf: m) ~= 0) implies that ((body occurrencesOf: m) ~= 0) "

	^ head metanotions
		allSatisfy:
			[ :m | (head occurrencesOf: m) ~= 0 ==> [ (body occurrencesOf: m) ~= 0 ] ]
]

{ #category : 'testing - boundness' }
AFHyperRule >> isRType [
	" A hyper rule is of the type R if and only if(iff)
		it is right-bound but not left-bound. "

	^ self isRightBound and: [ self isLeftBound not ]
]

{ #category : 'testing' }
AFHyperRule >> isRepresentation [
	"head is metanotion free and the body is a terminal"

	^ head isProtonotion and: [ body size = 1 and: [ body first isTerminal ] ]
]

{ #category : 'testing - boundness' }
AFHyperRule >> isRightBound [
	" right-bound if and only if(iff) for all m in metanotions:
		((body occurrencesOf: m) ~= 0) implies that ((head occurrencesOf: m) ~= 0) "

	^ body metanotions
		allSatisfy: [ :m | (body occurrencesOf: m) ~= 0 ==> [ (head occurrencesOf: m) ~= 0 ] ]
]

{ #category : 'testing' }
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

{ #category : 'testing - boundness' }
AFHyperRule >> isXType [
	" A hyper rule is of the type X if and only if(iff)
		it is neither left-bound nor right-bound. "

	^ self isLeftBound not and: [ self isRightBound not ]
]

{ #category : 'printing' }
AFHyperRule >> printOn: aStream [

	aStream
		print: head;
		nextPutAll: ': ';
		print: body;
		nextPut: $.
]

{ #category : 'printing' }
AFHyperRule >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]

{ #category : 'initialize-release' }
AFHyperRule >> release [
	head := body := nil.
	super release
]
