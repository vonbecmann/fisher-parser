Extension { #name : #ESTreeNode }

{ #category : #'*FisherParser-Core' }
ESTreeNode >> asProtonotion [
	" a new protonotion with terminals as small syntactic marks "

	^ AWProtonotion
		with:
			(String
				streamContents: [ :s | 
					ESTreeVisitor depthFirst new
						preOrderBlock: [ :node | 
							node model isTerminal
								ifTrue: [ s nextPut: node model reason ] ];
						visit: self ])
]
