Extension { #name : 'ESParseTree' }

{ #category : '*FisherParser-Core' }
ESParseTree >> hyperRule [
	ESTreeVisitor depthFirst new
		preOrderBlock: [ :node | ^ node model reason first ];
		visit: tree
]

{ #category : '*FisherParser-Core' }
ESParseTree >> solution [
		ESTreeVisitor depthFirst new
		preOrderBlock: [ :node | ^ node model reason second ];
		visit: tree
]
