Extension { #name : #ESTree }

{ #category : #'*FisherParser-Core' }
ESTree >> substitutionsOf: metanotions [
	"	a hypernotion match a protonotion, you need the relative substitution.
		each metanotion should have a unique substitute. "

	| substitutions |
	substitutions := AFMetanotionSubstitutions new.
	root children
		select: [ :child | metanotions includes: child model symbol ]
		thenDo: [ :child | substitutions add: child model symbol -> child asProtonotion ].
	^ (substitutions uniquelyAssign: metanotions)
			ifTrue: [ AFSubstitution solution: substitutions ]
			ifFalse: [ AFSubstitution noSolution ]
]
