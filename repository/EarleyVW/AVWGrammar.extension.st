Extension { #name : #AVWGrammar }

{ #category : #'*EarleyVW' }
AVWGrammar class >> evw: aVWRuleString representations: terminalNotionToRepresentationList [
	" parse VW rules from a String and return a vw-grammar "

	| array metarules metanotions hyperrules terminals |
	terminals := Set new.
	terminalNotionToRepresentationList do: [ :assoc | terminals add: assoc value ].
	array := JEVWParser instance parse: aVWRuleString.
	metarules := array first.
	metanotions := Set new.
	metarules do: [ :each | metanotions add: each head ].
	hyperrules := OrderedCollection withAll: array second.
	terminalNotionToRepresentationList
		collect: [ :assoc | 
			AWHyperRule
				head: (AWHypernotion withAll: (assoc key collect: [ :n | n asNotion ]))
				body: {(AWHypernotion with: assoc value)} ]
		thenDo: [ :hrule | hyperrules add: hrule ].
	^ self basicNew
		initializeMetanotions: metanotions
			metarules: metarules
			hyperrules: hyperrules
			terminals: terminals;
		yourself
]
