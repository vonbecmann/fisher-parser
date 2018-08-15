"
a hypernotion used by the algorithm.


use jay earley parser as a pattern matching algorithm.
the hypernotion system is uniquely assignable (u.a.) [On Parsing Two-Level Grammars, Lutz Michael Wegner]

Definition 12. Let M, V, Rm be defined as for two-level grammars(Definition 1). A hypernotion system HS is a 4-tuple (M, V, Rm, H), where H in (M u V)+, the hypernotion (axiom).
The language of a hypernotion system HS = (M, V, Rm, H) where H contains the n>=0 metanotions W1, W2, ..., Wn is defined as L(HS) = {phi(H) | phi is a homomorphism with phi(v) = v for v in V and phi(Wi) in L((M, V, Rm, Wi)) for all 1<=i<=n}.

Definition 13. If HS=(M, V, Rm, H) is a hypernotion system with H = X1X2...Xn, Xi in (M u V) for 1<=i<=n, then HS is uniquely assignable (u.a.) if for all w in L(HS) there is exactly on partition (p1, p2, ..., pn) such that.  w = p1p2...pn and phi(Xi) = pi for phi homomorphism of Definition 12.
"
Class {
	#name : #AFHypernotion,
	#superclass : #Object,
	#instVars : [
		'notions',
		'metanotions',
		'metaGrammar',
		'grammar',
		'backwardCrossReferences',
		'forwardCrossReferences',
		'firstSet'
	],
	#category : #'FisherParser-Core-Implementation'
}

{ #category : #'instance creation' }
AFHypernotion class >> belongsTo: aVWGrammar with: aNotion [
	^ (self with: aNotion)
		belongsTo: aVWGrammar;
		yourself
]

{ #category : #'instance creation' }
AFHypernotion class >> belongsTo: aVWGrammar withAll: aNotionCollection [
	^ (self withAll: aNotionCollection)
			belongsTo: aVWGrammar;
			yourself
]

{ #category : #'instance creation' }
AFHypernotion class >> belongsTo: aVWGrammar withAllNotionsFrom: anotherHypernotion [
	^ (self withAll: anotherHypernotion notions)
			belongsTo: aVWGrammar;
			yourself
]

{ #category : #'instance creation' }
AFHypernotion class >> empty [
	^ self new
]

{ #category : #'instance creation' }
AFHypernotion class >> new [
	^ self basicNew initializeNotions: #()
]

{ #category : #'instance creation' }
AFHypernotion class >> with: aNotion [
	^ self basicNew initializeNotions: (Array with: aNotion)
]

{ #category : #'instance creation' }
AFHypernotion class >> withAll: aNotionCollection [
	^ self basicNew
		initializeNotions: aNotionCollection;
		yourself
]

{ #category : #comparing }
AFHypernotion >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].
	self class == anObject class
		ifFalse: [ ^ false ].
	self size == anObject size
		ifFalse: [ ^ false ].
	1 to: notions size do: [ :index | 
		(notions at: index) = (anObject at: index)
			ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #'cross references' }
AFHypernotion >> addBackwardCrossReference: anAFHyperRule [ 
	backwardCrossReferences add: anAFHyperRule 
]

{ #category : #'cross references' }
AFHypernotion >> addForwardCrossReference: anAFHyperRule [
	forwardCrossReferences add: anAFHyperRule
]

{ #category : #accessing }
AFHypernotion >> apply: aSubstitution [
	^ (self class withAll: (notions collect: [ :notion | notion apply: aSubstitution ]))
		belongsTo: metaGrammar;
		backwardCrossReferences: backwardCrossReferences;
		forwardCrossReferences: forwardCrossReferences;
		yourself
]

{ #category : #accessing }
AFHypernotion >> asNonterminal [
	" must be a unique nonterminal "

	^ NCNonterminal
		named:
			(String
				streamContents: [ :s | 
					self printOn: s.
					s nextPut: $#.
					self identityHash printOn: s ])
]

{ #category : #accessing }
AFHypernotion >> at: index [
	^ notions at: index
]

{ #category : #'cross references' }
AFHypernotion >> backwardCrossReferences: aHyperRuleCollection [ 
	backwardCrossReferences := aHyperRuleCollection
]

{ #category : #'cross references' }
AFHypernotion >> backwardCrossReferencesDo: aBlock [
	backwardCrossReferences do: aBlock
]

{ #category : #accessing }
AFHypernotion >> belongsTo: aMetaGrammar [ 
	metaGrammar := aMetaGrammar
	
]

{ #category : #accessing }
AFHypernotion >> buildBodyOf: symbols [
	"build body of symbols using those given as parameters"

	^ Array
		streamContents: [ :s | 
			notions
				do: [ :each | 
					each isMetanotion
						ifTrue: [ s nextPut: (symbols detect: [ :symbol | symbol = each ]) ].
					each isProtonotion
						ifTrue: [ s nextPutAll: (each buildBodyOf: symbols) ].
					each isTerminal
						ifTrue: [ s nextPut: (symbols detect: [ :symbol | symbol = each ]) ] ] ]
]

{ #category : #testing }
AFHypernotion >> checkIsLLOne [
	| followSet parseTable conflictKeys |
	followSet := self computeFollowSet.
	parseTable := self computeParseTableUsing: followSet.
	conflictKeys := parseTable keys select: [ :key | (parseTable at: key) size > 1 ].
	conflictKeys isEmpty
		ifFalse: [ 
			Error
				signal:
					(String
						streamContents: [ :s | 
							s nextPutAll: 'CONFLICT at '.
							conflictKeys do: [ :key | s print: key ] separatedBy: [ s space ] ]) ]
]

{ #category : #accessing }
AFHypernotion >> computeFirstSet [
	| previousSize |
	firstSet := MultiValuedDictionary dictionary: IdentityDictionary collection: Set.
	self grammar nonterminals do: [ :each | firstSet at: each putAll: #() ].
	[	previousSize := firstSet size.
		self grammar productionRules 
			do: [ :rule | firstSet at: rule head putAll: (firstSet firstOf: rule body) ].
		previousSize = firstSet size ] whileFalse
]

{ #category : #private }
AFHypernotion >> computeFollowSet [
	| followSet previousSize symbolFollowSet rest restFirstSet |
	followSet := MultiValuedDictionary dictionary: IdentityDictionary collection: Set.
	self grammar nonterminals do: [ :each | followSet at: each putAll: #() ].
	followSet at: self grammar startSymbol put: #endmarker.
	[ previousSize := followSet size.
	self grammar productionRules
		do: [ :rule | 
			rule body
				withIndexDo: [ :symbol :index | 
					symbol isNonterminal
						ifTrue: [ 
							symbolFollowSet := Set new.
							rest := rule body copyFrom: index + 1 to: rule body size.
							rest isEmpty
								ifTrue: [ symbolFollowSet addAll: (followSet at: rule head) ]
								ifFalse: [ 
									restFirstSet := firstSet firstOf: rest.
									(restFirstSet includes: #epsilon)
										ifTrue: [ symbolFollowSet addAll: (followSet at: rule head) ].
									symbolFollowSet addAll: (restFirstSet copyWithout: #epsilon) ].
							followSet at: symbol putAll: symbolFollowSet ] ] ].
	previousSize = followSet size ] whileFalse.
	^ followSet 
]

{ #category : #private }
AFHypernotion >> computeParseTableUsing: followSet [
	" compute parse table using first set and follow test. 
	  then you can test if there's a conflict "
	| parseTable |
	parseTable := MultiValuedDictionary dictionary: Dictionary collection: Set.
	self grammar productionRules
		do: [ :rule | 
			| bodyFirstSet |
			bodyFirstSet := firstSet firstOf: rule body.
			(self grammar terminals intersection: bodyFirstSet)
				do: [ :terminal | 
					parseTable 
						at: (OrderedPair first: rule head second: terminal) 
						put: rule ].
			(bodyFirstSet includes: #epsilon)
				ifTrue: [ 
					(self grammar terminals intersection: (followSet at: rule head))
						do: [ :terminal | 
							parseTable 
								at: (OrderedPair first: rule head second: terminal) 
								put: rule ] ] ].
	^ parseTable 					

]

{ #category : #accessing }
AFHypernotion >> firstSet [
	^ firstSet at: self grammar startSymbol
]

{ #category : #'cross references' }
AFHypernotion >> forwardCrossReferences [
	^ forwardCrossReferences
]

{ #category : #'cross references' }
AFHypernotion >> forwardCrossReferences: aHyperRuleCollection [ 
	forwardCrossReferences := aHyperRuleCollection
]

{ #category : #'cross references' }
AFHypernotion >> forwardCrossReferencesDo: aBlock [
	forwardCrossReferences do: aBlock
]

{ #category : #private }
AFHypernotion >> grammar [
	^ grammar ifNil: [ grammar := metaGrammar startAt: self ]
]

{ #category : #'inspector extensions' }
AFHypernotion >> gtDisplayOn: aStream [
	notions 
		do: [ :each | each printOn: aStream ] 
		separatedBy: [ aStream space ]
]

{ #category : #'inspector extensions' }
AFHypernotion >> gtInspectorBackwardCrossReferencesIn: composite [
	<gtInspectorPresentationOrder: 2>
	^ composite list
		title: [ 'Backward X-Ref' ];
		display: [ backwardCrossReferences ];
		format: [ :each | GTObjectPrinter new asTruncatedTextFrom: each ];
		showOnly: 50;
		yourself
]

{ #category : #'inspector extensions' }
AFHypernotion >> gtInspectorForwardCrossReferencesIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ composite list
		title: [ 'Forward X-Ref' ];
		display: [ forwardCrossReferences ];
		format: [ :each | GTObjectPrinter new asTruncatedTextFrom: each ];
		showOnly: 50;
		yourself
]

{ #category : #'inspector extensions' }
AFHypernotion >> gtInspectorNotionsIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ composite list
		title: [ notions size asString, ' notions' ];
		display: [ notions ];
		format: [ :each | GTObjectPrinter new asTruncatedTextFrom: each ];
		showOnly: 50;
		yourself
]

{ #category : #comparing }
AFHypernotion >> hash [
	| hash |
	hash := self class hash.
	notions do: [ :each | hash := (hash + each hash) hashMultiply ].
	^ hash
]

{ #category : #initialization }
AFHypernotion >> initialize [
	metanotions := Set new.
	metaGrammar := nil.
	grammar := nil.
	backwardCrossReferences := Set new.
	forwardCrossReferences := Set new.
	firstSet := nil
]

{ #category : #initialization }
AFHypernotion >> initializeNotions: aNotionCollection [
	self initialize.
	notions := aNotionCollection.
	notions
		do: [ :each | 
			each isMetanotion
				ifTrue: [ metanotions add: each ] ]
]

{ #category : #testing }
AFHypernotion >> isEmpty [
	^ notions isEmpty
]

{ #category : #testing }
AFHypernotion >> isHypernotion [
	^ notions isEmpty or: [ metanotions isNotEmpty ]
]

{ #category : #testing }
AFHypernotion >> isProtonotion [
	"its metanotion free"

	^ metanotions isEmpty
		and: [ notions isNotEmpty 
					and: [ notions allSatisfy: [ :notion | notion isProtonotion ] ] ]
]

{ #category : #testing }
AFHypernotion >> isStrict [
	^ metanotions isEmpty
]

{ #category : #testing }
AFHypernotion >> isTerminal [
	^ metanotions isEmpty
		and: [ notions isNotEmpty and: [ notions allSatisfy: [ :notion | notion isTerminal ] ] ]
]

{ #category : #matching }
AFHypernotion >> match: aProtonotionHypernotion [
	"	a hypernotion match a protonotion, you need the relative substitution. "

	^ [ (self grammar parse: aProtonotionHypernotion asString) substitutionsOf: metanotions ]
		on: JEFailure
		do: [ AFSubstitution noSolution ]
]

{ #category : #matching }
AFHypernotion >> match: aProtonotionHypernotion do: aBlock [
	(self match: aProtonotionHypernotion) ifSolution: aBlock
]

{ #category : #matching }
AFHypernotion >> matchEmptyDo: aBlock [
	(self match: String empty) ifSolution: aBlock
]

{ #category : #matching }
AFHypernotion >> matches: aCharacter [ 
	^ notions first matches: aCharacter 
]

{ #category : #testing }
AFHypernotion >> matchesEmpty [
	^ self grammar accepts: String empty
]

{ #category : #accessing }
AFHypernotion >> metanotions [
	^ metanotions
]

{ #category : #testing }
AFHypernotion >> occurrencesOf: aNotion [ 
	^ notions occurrencesOf: aNotion 
]

{ #category : #printing }
AFHypernotion >> printOn: aStream [
	notions do: [ :each | each printOn: aStream ]
]

{ #category : #printing }
AFHypernotion >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]

{ #category : #'initialize-release' }
AFHypernotion >> release [
	notions := metanotions := metaGrammar := nil.
	grammar := forwardCrossReferences := firstSet := nil.
	super release
]

{ #category : #accessing }
AFHypernotion >> size [
	^ notions size
]

{ #category : #matching }
AFHypernotion >> superMatches: anAFHypernotion [
	self isProtonotion
		ifTrue: [ ^ (anAFHypernotion match: self) isSolution ].
	anAFHypernotion isProtonotion
		ifTrue: [ ^ (self match: anAFHypernotion) isSolution ].
	^ (self firstSet intersection: anAFHypernotion firstSet) isNotEmpty
]
