Extension { #name : #ESTree }

{ #category : #'*FisherParser-Core' }
ESTree >> metanotionSubstitutionsOf: aHypernotion [
	| substitutions metanotions |
	substitutions := SinglyLinkedList new.
	metanotions := aHypernotion metanotions.
	root children
		do: [ :child | 
			metanotions
				detect: [ :metanotion | metanotion named = child model symbol named ]
				ifFound: [ :metanotion | 
					| substitute |
					substitute := AWProtonotion
						with:
							(String
								streamContents: [ :s | 
									ESTreeVisitor depthFirst new
										preOrderBlock: [ :node | 
											node model isTerminal
												ifTrue: [ s nextPut: node model reason ] ];
										visit: child ]).
					substitutions addLast: metanotion named -> substitute ] ].
	^ substitutions
]
