Extension { #name : #AVWGrammar }

{ #category : #'*EarleyVW' }
AVWGrammar class >> evw: aVWRuleString representations: terminalNotionToRepresentationList [
	" parse VW rules from a String and build a vw-grammar "

	| vwRules builder |
	vwRules := JEVWParser instance parse: aVWRuleString.
	builder := AVWGrammarBuilder new.
	builder metaRules: vwRules first.
	builder hyperRules: vwRules second.
	builder representations: terminalNotionToRepresentationList.
	^ builder build
]
