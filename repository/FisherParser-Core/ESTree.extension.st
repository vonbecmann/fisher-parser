Extension { #name : #ESTree }

{ #category : #'*FisherParser-Core' }
ESTree >> substitutionsOf: metanotions [
	| substitutions |
	substitutions := Set new.
	root children
		do: [ :child | 
			metanotions
				detect: [ :metanotion | metanotion = child model symbol ]
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
					substitutions add: (metanotion -> substitute) ] ].
	^ substitutions 
]
