"
a metanotion is a non-empty sequence of large syntactic marks that is defined in the metaproductions. (e.g., *ALPHA*)
However, care must be taken in choosing the metanotions so that any sequence of metanotions is no also a different sequence of metanotions. For example, if *A* and *B* are metanotions then *AB* should not be a third metanotion; otherwise unintended ambiguity may arise.

- ""large syntactic marks"" as $A-$Z, $0-$9.
"
Class {
	#name : #AWMetanotion,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'AWijngaarden-Core'
}

{ #category : #'instance creation' }
AWMetanotion class >> named: aString [
	^ self basicNew initializeName: aString
]

{ #category : #comparing }
AWMetanotion >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].
	^ self class == anObject class and: [ name == anObject named ]
]

{ #category : #comparing }
AWMetanotion >> hash [
	^ (self class hash + name hash) hashMultiply
]

{ #category : #initialization }
AWMetanotion >> initializeName: aString [ 
	self initialize.
	name := aString asSymbol
]

{ #category : #testing }
AWMetanotion >> isMetanotion [
	^ true
]

{ #category : #testing }
AWMetanotion >> isProtonotion [
	^ false
]

{ #category : #testing }
AWMetanotion >> isTerminal [
	^ false
]

{ #category : #accessing }
AWMetanotion >> named [
	^ name
]

{ #category : #printing }
AWMetanotion >> printOn: aStream [
	aStream nextPutAll: name
]

{ #category : #printing }
AWMetanotion >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]
