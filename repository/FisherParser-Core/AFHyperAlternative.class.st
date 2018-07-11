"
- A ""hyperalternative"" is a nonempty sequence of hypernotions separated by commas.
"
Class {
	#name : #AFHyperAlternative,
	#superclass : #Object,
	#instVars : [
		'hypernotions',
		'metanotions'
	],
	#category : #'FisherParser-Core-Implementation'
}

{ #category : #'instance creation' }
AFHyperAlternative class >> with: anAFHypernotion [
	^ self basicNew initializeHypernotions: (Array with: anAFHypernotion)
]

{ #category : #'instance creation' }
AFHyperAlternative class >> withAll: anAFHypernotionCollection [
	^ self basicNew initializeHypernotions: (Array withAll: anAFHypernotionCollection)
]

{ #category : #comparing }
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

{ #category : #accessing }
AFHyperAlternative >> apply: aSubstitution [
	^ self class withAll: (hypernotions collect: [ :each | each apply: aSubstitution ])
]

{ #category : #accessing }
AFHyperAlternative >> at: index [
	^ hypernotions at: index
]

{ #category : #enumerating }
AFHyperAlternative >> do: aBlock [
	hypernotions do: aBlock
]

{ #category : #accessing }
AFHyperAlternative >> first [
	^ hypernotions first
]

{ #category : #'inspector extensions' }
AFHyperAlternative >> gtDisplayOn: aStream [
	hypernotions 
		do: [ :hn | hn gtDisplayOn: aStream ] 
		separatedBy: [ aStream nextPutAll: ', ' ]
]

{ #category : #'inspector extensions' }
AFHyperAlternative >> gtDisplayOn: aStream withDotAt: dotIndex [
	| middleDot |
	middleDot := Character value: 183.
	hypernotions
		withIndexDo: [ :each :index | 
			index == 1
				ifFalse: [ aStream nextPutAll: ', ' ].
			index == dotIndex
				ifTrue: [ aStream nextPut: middleDot ].
			each gtDisplayOn: aStream ].
	dotIndex > hypernotions size
		ifTrue: [ aStream nextPut: middleDot ]
]

{ #category : #'inspector extensions' }
AFHyperAlternative >> gtInspectorHypernotionsIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ composite list
		title: [ hypernotions size asString , ' hypernotions' ];
		display: [ hypernotions ];
		format: [ :each | GTObjectPrinter new asTruncatedTextFrom: each ];
		showOnly: 50;
		yourself
]

{ #category : #comparing }
AFHyperAlternative >> hash [
	| hash |
	hash := (self class hash + hypernotions size hash) hashMultiply.
	hypernotions do: [ :each | hash := (hash + each hash) hashMultiply ].
	^ hash
]

{ #category : #initialization }
AFHyperAlternative >> initialize [
	metanotions := Set new
]

{ #category : #initialization }
AFHyperAlternative >> initializeHypernotions: anAFHypernotionArray [
	self initialize.
	hypernotions := anAFHypernotionArray.
	hypernotions do: [ :hn | metanotions addAll: hn metanotions ]
]

{ #category : #testing }
AFHyperAlternative >> isEmpty [
	^ hypernotions isEmpty
]

{ #category : #accessing }
AFHyperAlternative >> metanotions [
	^ metanotions
]

{ #category : #testing }
AFHyperAlternative >> occurrencesOf: aNotion [
	| tally |
	tally := 0.
	hypernotions do: [ :hn | tally := tally + (hn occurrencesOf: aNotion) ].
	^ tally
]

{ #category : #printing }
AFHyperAlternative >> printOn: aStream [
	hypernotions do: [ :hn | aStream print: hn ] separatedBy: [ aStream nextPutAll: ', ' ]
]

{ #category : #printing }
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

{ #category : #printing }
AFHyperAlternative >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]

{ #category : #'initialize-release' }
AFHyperAlternative >> release [
	hypernotions := metanotions := nil.
	super release
]

{ #category : #accessing }
AFHyperAlternative >> size [
	^ hypernotions size
]
