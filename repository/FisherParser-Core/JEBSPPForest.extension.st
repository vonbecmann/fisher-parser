Extension { #name : #JEBSPPForest }

{ #category : #'*FisherParser-Core' }
JEBSPPForest >> substitutionsOf: metanotions [
	"	a hypernotion match a protonotion, you need the relative substitution.
		each metanotion should have a unique substitute. "

	^ metanotions isEmpty
		ifTrue: [ AFSubstitution emptySolution ]
		ifFalse: [ | substitutions |
			substitutions := MultiValuedDictionary dictionary: IdentityDictionary collection: SinglyLinkedList.
			JEDepthFirstVisitor new
				postOrderNodeBlock: [ :packed | 
					substitutions at: packed putAll: (packed sumFamilySubstitutionsAt: substitutions) ];
				preOrderFamilyBlock: [ :family | 
					(family parent isNonterminal and: [ family parent head = root head ])
						ifTrue: [ 
							family children
								select: [ :node | node isNonterminal and: [ metanotions includes: node head ] ]
								thenDo: [ :node | substitutions at: node put: node asMetanotionSubstitution ]  ] ];
				postOrderFamilyBlock: [ :family | 
					substitutions at: family putAll: (family productMemberSubstitutionsAt: substitutions) ];
				visit: self.
			(substitutions at: root)
				detect: [ :each | each uniquelyAssign: metanotions ]
				ifFound: [ :found | AFSubstitution solution: found ]
				ifNone: [ AFSubstitution noSolution ] ]
]
