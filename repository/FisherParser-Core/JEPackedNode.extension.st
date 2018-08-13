Extension { #name : #JEPackedNode }

{ #category : #'*FisherParser-Core' }
JEPackedNode >> asMetanotionSubstitution [
	^ AFMetanotionSubstitutions with: self model head -> self asProtonotion
]

{ #category : #'*FisherParser-Core' }
JEPackedNode >> asProtonotion [
	" a new protonotion with terminals as small syntactic marks "

	^ AWProtonotion
		with:
			(String
				streamContents: [ :s | 
					JETreeDepthFirstVisitor new
						preOrderNodeBlock: [ :node | 
							node model isTerminal
								ifTrue: [ s nextPut: node model word ] ];
						visit: self ])
]

{ #category : #'*FisherParser-Core' }
JEPackedNode >> sumFamilySubstitutionsAt: substitutions [
	| familySubstitutions |
	familySubstitutions := SinglyLinkedList new.
	families do: [ :family | familySubstitutions addAll: (substitutions at: family) ].
	^ familySubstitutions
]
