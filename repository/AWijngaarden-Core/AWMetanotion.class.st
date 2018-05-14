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

{ #category : #initialization }
AWMetanotion >> initializeName: aString [ 
	self initialize.
	name := aString asSymbol
]

{ #category : #testing }
AWMetanotion >> isTerminal [
	^ false
]

{ #category : #printing }
AWMetanotion >> printOn: aStream [
	aStream nextPutAll: name
]
