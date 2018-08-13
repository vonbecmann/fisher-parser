Extension { #name : #JEFamily }

{ #category : #'*FisherParser-Core' }
JEFamily >> productMemberSubstitutionsAt: substitutions [
	^ self isEmpty
		ifTrue: [ #() ]
		ifFalse: [ | memberSubstitutions |
			memberSubstitutions := substitutions at: first.
			second ifNotNil: [ memberSubstitutions := memberSubstitutions product: (substitutions at: second) ].
			memberSubstitutions ]
]
