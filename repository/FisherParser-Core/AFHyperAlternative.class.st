"
- A ""hyperalternative"" is a nonempty sequence of hypernotions separated by commas.
"
Class {
	#name : 'AFHyperAlternative',
	#superclass : 'Object',
	#instVars : [
		'hypernotions'
	],
	#category : 'FisherParser-Core-Implementation',
	#package : 'FisherParser-Core',
	#tag : 'Implementation'
}

{ #category : 'instance creation' }
AFHyperAlternative class >> with: anAFHypernotion [
	^ self basicNew initializeHypernotions: (Array with: anAFHypernotion)
]

{ #category : 'instance creation' }
AFHyperAlternative class >> withAll: anAFHypernotionCollection [
	^ self basicNew initializeHypernotions: (Array withAll: anAFHypernotionCollection)
]

{ #category : 'comparing' }
AFHyperAlternative >> = anObject [
	self class == anObject class
		ifFalse: [ ^ false ].
	hypernotions size == anObject size
		ifFalse: [ ^ false ].
	1 to: hypernotions size do: [ :index | 
		(hypernotions at: index) = (anObject at: index)
			ifFalse: [ ^ false ] ].
	^ true
]

{ #category : 'accessing' }
AFHyperAlternative >> apply: aSubstitution [
	^ self class withAll: (hypernotions collect: [ :each | each apply: aSubstitution ])
]

{ #category : 'accessing' }
AFHyperAlternative >> at: index [
	^ hypernotions at: index
]

{ #category : 'displaying' }
AFHyperAlternative >> displayStringOn: aStream [

	hypernotions
		do: [ :hn | hn displayStringOn: aStream ]
		separatedBy: [ aStream nextPutAll: ', ' ]
]

{ #category : 'displaying' }
AFHyperAlternative >> displayStringOn: aStream withDotAt: dotIndex [

	| middleDot |
	middleDot := Character value: 183.
	hypernotions withIndexDo: [ :each :index | 
		index == 1 ifFalse: [ aStream nextPutAll: ', ' ].
		index == dotIndex ifTrue: [ aStream nextPut: middleDot ].
		each displayStringOn: aStream ].
	dotIndex > hypernotions size ifTrue: [ aStream nextPut: middleDot ]
]

{ #category : 'accessing' }
AFHyperAlternative >> first [
	^ hypernotions first
]

{ #category : 'comparing' }
AFHyperAlternative >> hash [
	| hash |
	hash := (self class hash + hypernotions size hash) hashMultiply.
	hypernotions do: [ :each | hash := (hash + each hash) hashMultiply ].
	^ hash
]

{ #category : 'initialization' }
AFHyperAlternative >> initializeHypernotions: anAFHypernotionArray [
	hypernotions := anAFHypernotionArray
]

{ #category : 'inspector extensions' }
AFHyperAlternative >> inspectionHypernotionsIn: aBuilder [

	<inspectorPresentationOrder: 0 title: 'Hypernotions'>
	^ aBuilder newList
		  items: hypernotions;
		  display: [ :each | StObjectPrinter asTruncatedTextFrom: each ];
		  yourself
]

{ #category : 'testing' }
AFHyperAlternative >> isEmpty [
	^ hypernotions isEmpty
]

{ #category : 'testing' }
AFHyperAlternative >> isStrict [
	^ hypernotions allSatisfy: [ :hn | hn isStrict ]
]

{ #category : 'accessing' }
AFHyperAlternative >> metanotions [
	| metanotions |
	metanotions := Set new.
	hypernotions do: [ :hn | metanotions addAll: hn metanotions ].
	^ metanotions
]

{ #category : 'testing' }
AFHyperAlternative >> occurrencesOf: aNotion [
	| tally |
	tally := 0.
	hypernotions do: [ :hn | tally := tally + (hn occurrencesOf: aNotion) ].
	^ tally
]

{ #category : 'printing' }
AFHyperAlternative >> printOn: aStream [
	hypernotions do: [ :hn | aStream print: hn ] separatedBy: [ aStream nextPutAll: ', ' ]
]

{ #category : 'printing' }
AFHyperAlternative >> printOn: aStream withDotAt: dotIndex [
	| middleDot |
	middleDot := Character value: 183.
	hypernotions
		withIndexDo: [ :each :index | 
			index == 1
				ifFalse: [ aStream nextPutAll: ', ' ].
			index == dotIndex
				ifTrue: [ aStream nextPut: middleDot ].
			each printOn: aStream ].
	dotIndex > hypernotions size
		ifTrue: [ aStream nextPut: middleDot ]
]

{ #category : 'printing' }
AFHyperAlternative >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]

{ #category : 'initialize-release' }
AFHyperAlternative >> release [
	hypernotions := nil.
	super release
]

{ #category : 'accessing' }
AFHyperAlternative >> size [
	^ hypernotions size
]

{ #category : 'enumerating' }
AFHyperAlternative >> withIndexDo: aBlock [ 
	hypernotions withIndexDo: aBlock 
]
