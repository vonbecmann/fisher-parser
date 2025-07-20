"
a parse forest of a vw-grammar.

syntaxForest - a BSPPForest
"
Class {
	#name : 'AFParseForest',
	#superclass : 'Object',
	#instVars : [
		'syntaxForest',
		'grammar'
	],
	#category : 'FisherParser-Core-Public',
	#package : 'FisherParser-Core',
	#tag : 'Public'
}

{ #category : 'instance creation' }
AFParseForest class >> given: aBSPPForest of: aVWGrammar [
	"given a syntax forest of a grammar"

	^ self basicNew
		initializeSyntaxForest: aBSPPForest
		andGrammar: aVWGrammar
]

{ #category : 'parsing' }
AFParseForest >> extractSingleParseTree [
	"the forest has one binary tree, so we need to extract it from the forest. 
	 but flatten as the production rules and using syntax nodes."

	| stack |
	stack := SinglyLinkedStack new.
	JETreeDepthFirstVisitor new
		postOrderNodeBlock: [ :node |
				node model isTerminal
					ifTrue: [
						stack push: (ESTreeNode model: node model asSyntaxNode) ]
					ifFalse: [
							node model isFinal ifTrue: [
										stack push: (ESTreeNode
													 model: node model asSyntaxNode
													 children:
														 (stack popReversed:
																  node model dottedHyperRule body size)) ] ] ];
		visit: syntaxForest.
	self assert: [ stack size = 1 ].
	^ ESParseTree given: (ESTree rootNode: stack pop) of: grammar
]

{ #category : 'initialization' }
AFParseForest >> initializeSyntaxForest: aBSPPForest andGrammar: aVWGrammar [
	syntaxForest := aBSPPForest.
	grammar := aVWGrammar
]

{ #category : 'inspector extensions' }
AFParseForest >> inspectionBrowserIn: builder [

	<inspectorPresentationOrder: 1 title: 'Browse'>
	^ syntaxForest inspectionBrowserIn: builder
]

{ #category : 'testing' }
AFParseForest >> isAmbiguous [

	AFDepthFirstVisitor new
		preOrderNodeBlock: [ :packed |
			packed familiesSize > 1 ifTrue: [ ^ true ] ];
		visit: syntaxForest.
	^ false
]

{ #category : 'printing' }
AFParseForest >> printOn: aStream [
	aStream
		nextPutAll: self className;
		nextPut: $(;
		print: syntaxForest;
		nextPut: $)
]

{ #category : 'printing' }
AFParseForest >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]
