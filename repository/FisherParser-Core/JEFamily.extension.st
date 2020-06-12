Extension { #name : #JEFamily }

{ #category : #'*FisherParser-Core' }
JEFamily >> productMemberSubstitutionsAt: substitutions [
	^ self isEmpty
		ifTrue: [ #() ]
		ifFalse: [ | memberSubstitutions |
			memberSubstitutions := substitutions at: self first.
			self second ifNotNil: [ memberSubstitutions := memberSubstitutions product: (substitutions at: self second) ].
			memberSubstitutions ]
]
