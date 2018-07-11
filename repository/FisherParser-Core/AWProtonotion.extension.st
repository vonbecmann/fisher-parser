Extension { #name : #AWProtonotion }

{ #category : #'*FisherParser-Core' }
AWProtonotion >> apply: aSubstitution [ 
	^ self
]

{ #category : #'*FisherParser-Core' }
AWProtonotion >> buildBodyOf: symbols [
	^ Array
		new: smallSyntacticMarks size
		streamContents: [ :s | 
			smallSyntacticMarks
				collect: [ :letter | NCNonterminal named: letter ]
				thenDo: [ :orthoNonterminal | 
					s nextPut: (symbols detect: [ :symbol | symbol = orthoNonterminal ]) ] ]
]

{ #category : #'*FisherParser-Core' }
AWProtonotion >> strictSyntax [
	^ Array
		new: smallSyntacticMarks size
		streamContents: [ :s | 
			smallSyntacticMarks 
				do: [ :letter | s nextPut: (NCNonterminal named: letter) ] ]
]
