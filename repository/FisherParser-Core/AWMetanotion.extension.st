Extension { #name : #AWMetanotion }

{ #category : #'*FisherParser-Core' }
AWMetanotion >> apply: aSubstitution [ 
	^ aSubstitution applyTo: self
]
