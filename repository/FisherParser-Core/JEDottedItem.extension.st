Extension { #name : 'JEDottedItem' }

{ #category : '*FisherParser-Core' }
JEDottedItem >> asMetanotionSubstitution [
	^ AFMetanotionSubstitutions with: self head -> self asProtonotion
]

{ #category : '*FisherParser-Core' }
JEDottedItem >> asProtonotion [
	" a new protonotion with terminals as small syntactic marks "

	^ AWProtonotion with: (String streamContents: [ :s |
				   JETreeDepthFirstVisitor new
					   preOrderNodeBlock: [ :node |
						   node isTerminal ifTrue: [ s nextPut: node word ] ];
					   visit: self ])
]

{ #category : '*FisherParser-Core' }
JEDottedItem >> sumFamilySubstitutionsAt: substitutions [
	| familySubstitutions |
	familySubstitutions := SinglyLinkedList new.
	families do: [ :family | familySubstitutions addAll: (substitutions at: family) ].
	^ familySubstitutions
]
