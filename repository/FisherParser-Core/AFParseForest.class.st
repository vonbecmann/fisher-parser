"
a parse forest of a vw-grammar.

syntaxForest - a BSPPForest
"
Class {
	#name : #AFParseForest,
	#superclass : #Object,
	#instVars : [
		'syntaxForest'
	],
	#category : #'FisherParser-Core-Public'
}

{ #category : #'instance creation' }
AFParseForest class >> with: aBSPPForest [
	^ self basicNew
		initializeSyntaxForest: aBSPPForest;
		yourself
]

{ #category : #'inspector extensions' }
AFParseForest >> gtInspectorBrowserIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ syntaxForest gtInspectorBrowserIn: composite
]

{ #category : #initialization }
AFParseForest >> initializeSyntaxForest: aBSPPForest [ 
	syntaxForest := aBSPPForest 
]

{ #category : #testing }
AFParseForest >> isAmbiguous [
	AFDepthFirstVisitor new
		preOrderNodeBlock: [ :packed | 
			packed familiesSize > 1
				ifTrue: [ ^ true ] ];
		visit: syntaxForest.
	^ false
]

{ #category : #printing }
AFParseForest >> printOn: aStream [
	aStream
		nextPutAll: self className;
		nextPut: $(;
		print: syntaxForest;
		nextPut: $)
]

{ #category : #printing }
AFParseForest >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]
