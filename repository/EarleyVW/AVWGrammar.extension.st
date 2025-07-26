Extension { #name : 'AVWGrammar' }

{ #category : '*EarleyVW' }
AVWGrammar class >> evw: aVWRuleString representations: terminalNotionToRepresentationList [
	" parse VW rules from a String and build a vw-grammar "

	| vwRules |
	vwRules := JEVWParser instance parse: aVWRuleString.
	^ AVWGrammarBuilder new
		metaRules: vwRules first;
		hyperRules: vwRules second;
		representations: terminalNotionToRepresentationList;
		build
]
