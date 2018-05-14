"
- a *hypernotion* is a possibly empty sequence of metanotions and/or protonotions (e.g., *letter ALPHA*)


"
Class {
	#name : #AWHypernotion,
	#superclass : #Object,
	#instVars : [
		'notions'
	],
	#category : #'AWijngaarden-Core'
}

{ #category : #'instance creation' }
AWHypernotion class >> new [
	^ self basicNew initializeNotions: #()
]

{ #category : #'instance creation' }
AWHypernotion class >> with: aNotion [
	^ self basicNew initializeNotions: (Array with: aNotion)
]

{ #category : #'instance creation' }
AWHypernotion class >> withAll: aCollection [
	^ self basicNew
		initializeNotions:
			(Array
				new: aCollection size
				streamContents: [ :s | s nextPutAll: aCollection ]);
		yourself
]

{ #category : #'inspector extensions' }
AWHypernotion >> gtInspectorNotionsIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ composite list
		title: [ 'Notions' ];
		display: [ notions ];
		format: [ :each | GTObjectPrinter new asTruncatedTextFrom: each ];
		showOnly: 50;
		yourself
]

{ #category : #initialization }
AWHypernotion >> initializeNotions: aCollection [
	self initialize.
	notions := aCollection
]

{ #category : #testing }
AWHypernotion >> isEmpty [
	^ notions isEmpty
]

{ #category : #testing }
AWHypernotion >> isTerminal [
	^ notions size = 1 and: [ notions first isTerminal ]
]

{ #category : #printing }
AWHypernotion >> printOn: aStream [
	notions 
		do: [ :each | aStream print: each ] 
		separatedBy: [ aStream space ]
]
