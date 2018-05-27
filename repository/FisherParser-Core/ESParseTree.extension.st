Extension { #name : #ESParseTree }

{ #category : #'*FisherParser-Core' }
ESParseTree >> metanotionSubstitutionsOf: aHypernotion [ 
	| startNode substitutions metanotions |
	substitutions := IdentityDictionary new.
	startNode := tree nodeOf: aHypernotion.
	metanotions := aHypernotion metanotions.
	startNode children 
		select: [ :child | 
					metanotions 
						detect: [ :m | m named = child model symbol named ] 
						ifFound: [ true ]
						ifNone: [ false ] ]
		thenDo: [ :metanotionNode |
					substitutions
						add:
							metanotionNode model symbol named
								-> (AWProtonotion
										with:
											(String
												streamContents: [ :s | 
													ESTreeVisitor depthFirst new
														preOrderBlock: [ :node | 
															node model isTerminal
																ifTrue: [ s nextPut: node model reason ] ];
														visit: metanotionNode ]))
			 ].
	^ substitutions 
]
