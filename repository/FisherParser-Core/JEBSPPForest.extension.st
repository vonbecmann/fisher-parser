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
					substitutions at: packed putAll: (packed children flatCollect: [ :family | substitutions at: family ]) ];
				preOrderFamilyBlock: [ :family | 
					(family parent model isNonterminal and: [ family parent model head = root model head ])
						ifTrue: [ 
							family members
								do: [ :member | 
									(member model isNonterminal and: [ metanotions includes: member model head ])
										ifTrue: [ 
											substitutions 
												at: member 
												put: (AFMetanotionSubstitutions with: member model head -> member asProtonotion) ] ] ] ];
				postOrderFamilyBlock: [ :family | 
					substitutions
						at: family
						putAll: (family children inject: SinglyLinkedList new into: [ :subs :node | subs product: (substitutions at: node) ]) ];
				visit: self.
			(substitutions at: root)
				detect: [ :each | each uniquelyAssign: metanotions ]
				ifFound: [ :found | AFSubstitution solution: found ]
				ifNone: [ AFSubstitution noSolution ] ]
]
