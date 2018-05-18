Extension { #name : #AVWGrammar }

{ #category : #'*EarleyVW' }
AVWGrammar class >> evw: aVWRuleString representations: terminalNotionToRepresentationList [
	" parse VW rules from a String and return a vw-grammar "

	| vwRules metarules metanotions hyperrules terminals |
	self
		assert: terminalNotionToRepresentationList isNotEmpty
		description: 'The collection of rules cannot be empty.'.
	vwRules := JEVWParser instance parse: aVWRuleString.
	metarules := vwRules first.
	metanotions := Set new.
	metarules do: [ :each | metanotions add: each head ].
	hyperrules := OrderedCollection withAll: vwRules second.
	terminalNotionToRepresentationList
		collect: [ :assoc | 
			AWHyperRule
				head: (AWHypernotion withAll: (assoc key collect: [ :n | n asNotion ]))
				body: {(AWHypernotion with: assoc value)} ]
		thenDo: [ :hrule | hyperrules add: hrule ].
	terminals := Set new.
	terminalNotionToRepresentationList do: [ :assoc | terminals add: assoc value ].
	^ self basicNew
		initializeMetanotions: metanotions
			metarules: metarules
			hyperrules: hyperrules
			terminals: terminals;
		yourself
]
