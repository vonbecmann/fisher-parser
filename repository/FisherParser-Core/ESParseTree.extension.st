Extension { #name : #ESParseTree }

{ #category : #'*FisherParser-Core' }
ESParseTree >> metanotionSubstitutionsOf: aHypernotion [
	| substitutions metanotions |
	substitutions := SinglyLinkedList new.
	metanotions := aHypernotion metanotions.
	(tree nodeOf: aHypernotion) children
		select: [ :child | 
			metanotions 
				detect: [ :m | m named = child model symbol named ]
				ifFound: [ true ] 
				ifNone: [ false ] ]
		thenDo: [ :metanotionNode | 
			| substitute |
			substitute := AWProtonotion
				with: 	(String
							streamContents: [ :s | 
								ESTreeVisitor depthFirst new
									preOrderBlock: [ :node | 
										node model isTerminal ifTrue: [ s nextPut: node model reason ] ];
									visit: metanotionNode ]).
			substitutions addLast: metanotionNode model symbol named -> substitute ].
	^ substitutions
]
