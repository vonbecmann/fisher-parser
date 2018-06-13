Extension { #name : #ESTree }

{ #category : #'*FisherParser-Core' }
ESTree >> substitutionsOf: metanotions [
	| substitutions |
	substitutions := AFMetanotionSubstitutions new.
	root children
		select: [ :child | metanotions includes: child model symbol ]
		thenDo: [ :child | 
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
			substitutions add: child model symbol -> substitute ].
	^ substitutions
]
