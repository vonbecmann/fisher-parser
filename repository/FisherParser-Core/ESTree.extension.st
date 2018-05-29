Extension { #name : #ESTree }

{ #category : #'*FisherParser-Core' }
ESTree >> substitutionsOf: metanotions [
	| substitutions |
	substitutions := SinglyLinkedList new.
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
					substitutions addLast: metanotion -> substitute ] ].
	^ substitutions
]
