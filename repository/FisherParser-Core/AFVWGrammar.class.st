"
a vw grammar with some restrictions that Fisher mentions in his paper.

startNotion is a hypernotion. is a protonotion. 
	augments the given grammar with this hypernotion.
startHyperRule is hyper rule used by the algorithm.
	augments the given grammar with this hyper rule.


"
Class {
	#name : #AFVWGrammar,
	#superclass : #Object,
	#instVars : [
		'startNotion',
		'ortholetters',
		'vwGrammar',
		'startHyperRule',
		'alternatives',
		'representationRules',
		'grammarBuilder'
	],
	#category : #'FisherParser-Core-Public'
}

{ #category : #'instance creation' }
AFVWGrammar class >> evw: aVWRuleString representations: terminalNotionToRepresentationList [
	^ self basicNew
		initializeVWGrammar: 
			(AVWGrammar 
				evw: aVWRuleString 
				representations: terminalNotionToRepresentationList);
		yourself
]

{ #category : #testing }
AFVWGrammar >> accepts: aString [
	^ (AFRecognizer of: self) accepts: aString
]

{ #category : #private }
AFVWGrammar >> alternativesOf: aProtonotion [
	| alternativesOfProtonotion |
	alternativesOfProtonotion := SinglyLinkedList new.
	alternatives
		do: [ :hrule | 
			(self matches: hrule head against: aProtonotion)
				ifTrue: [ | substitute |
					substitute := 
						self 
							substitute: hrule 
							accordingTo: hrule head 
							thatAccepts: aProtonotion.
					alternativesOfProtonotion addLast: substitute ] ].
	^ alternativesOfProtonotion
]

{ #category : #testing }
AFVWGrammar >> analizeAccepts: aString [
	^ (AFAnalyticalRecognizer of: self) accepts: aString
]

{ #category : #private }
AFVWGrammar >> findNonterminal: nonterminal at: parse [
	ESTDepthFirstVisitor new
		preOrderBlock: [ :node | 
			node model reason head = nonterminal
				ifTrue: [ ^ node ] ];
		visit: parse.
	^ nil
]

{ #category : #'inspector extensions' }
AFVWGrammar >> gtInspectorDefinitionIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ vwGrammar gtInspectorDefinitionIn: composite
]

{ #category : #accessing }
AFVWGrammar >> hyperRulesSize [
	^ vwGrammar hyperRulesSize
]

{ #category : #accessing }
AFVWGrammar >> hypernotions [
	^ vwGrammar hypernotions
]

{ #category : #initialization }
AFVWGrammar >> initialize [
	super initialize.
	startNotion := AWHypernotion with: (AWProtonotion with: '((start))').
	ortholetters := Set new.
	startNotion do: [ :protonotion | protonotion do: [ :char | ortholetters add: char ] ]
]

{ #category : #initialization }
AFVWGrammar >> initializeVWGrammar: aVWGrammar [
	self initialize.
	vwGrammar := aVWGrammar.
	ortholetters addAll: vwGrammar ortholetters.
	grammarBuilder := AFGrammarBuilder
		metaRules: vwGrammar metaRules
		orthoRepresentations: (ortholetters collect: [ :char | char asSymbol -> (NCTerminal character: char) ]).
	startHyperRule := AFHyperRule head: startNotion body: {vwGrammar startNotion}.
	alternatives := SinglyLinkedList with: startHyperRule.
	vwGrammar hyperRules
		collect: [ :each | each asAFHyperRule ]
		thenDo: [ :newRule | alternatives addLast: newRule ].
	representationRules := alternatives
		select: [ :each | each isRepresentation ]
		thenCollect: [ :each | each dotAtBeginning ]
]

{ #category : #private }
AFVWGrammar >> matches: aHypernotion against: aProtonotion [
	| hnGrammar |
	hnGrammar := grammarBuilder buildStartingAt: aHypernotion.
	^ hnGrammar accepts: aProtonotion asStrictString
]

{ #category : #accessing }
AFVWGrammar >> metaRulesSize [
	^ vwGrammar metaRulesSize 
]

{ #category : #accessing }
AFVWGrammar >> metanotions [
	^ vwGrammar metanotions
]

{ #category : #printing }
AFVWGrammar >> printOn: aStream [
	"Append to the argument, aStream, a sequence of characters that  
	identifies the receiver."

	aStream
		nextPutAll: self class name;
		nextPut: $(;
		print: startHyperRule;
		nextPut: $)
]

{ #category : #printing }
AFVWGrammar >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]

{ #category : #accessing }
AFVWGrammar >> protonotions [
	^ vwGrammar protonotions 
]

{ #category : #private }
AFVWGrammar >> representationRules [
	^ representationRules
]

{ #category : #private }
AFVWGrammar >> startHyperRule [
	^ startHyperRule
]

{ #category : #accessing }
AFVWGrammar >> startNotion [
	^ startNotion
]

{ #category : #private }
AFVWGrammar >> substitute: aHyperRule accordingTo: aHypernotion thatAccepts: aProtonotion [
	| substitutions |
	substitutions := self substitutionsOf: aHypernotion thatAccepts: aProtonotion.
	^ aHyperRule substituteMetanotionsBy: substitutions
]

{ #category : #private }
AFVWGrammar >> substitutionsOf: aHypernotion thatAccepts: aProtonotion [
	| hnGrammar parse hnNode assocs metanodes |
	hnGrammar := grammarBuilder buildStartingAt: aHypernotion.
	parse := hnGrammar parseTree: aProtonotion asStrictString.
	hnNode := self findNonterminal: (NCNonterminal named: aHypernotion asString) at: parse.
	metanodes := SinglyLinkedList new.
	aHypernotion metanotions
		collect: [ :each | each asNonterminal ]
		thenDo: [ :nonterminal | 
			hnNode children
				select: [ :child | child reason head = nonterminal ]
				thenDo: [ :node | metanodes add: node ] ].
	assocs := SinglyLinkedList new.
	metanodes do: [ :mnode | assocs add: mnode reason head named -> '' ].
	^ Dictionary newFrom: assocs asArray
]

{ #category : #accessing }
AFVWGrammar >> terminals [
	^ vwGrammar terminals
]
