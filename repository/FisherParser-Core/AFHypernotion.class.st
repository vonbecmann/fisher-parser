"
a hypernotion used by the algorithm.


use jay earley parser as a pattern matching algorithm.
the hypernotion system is uniquely assignable (u.a.) [On Parsing Two-Level Grammars, Lutz Michael Wegner]

Definition 12. Let M, V, Rm be defined as for two-level grammars(Definition 1). A hypernotion system HS is a 4-tuple (M, V, Rm, H), where H in (M u V)+, the hypernotion (axiom).
The language of a hypernotion system HS = (M, V, Rm, H) where H contains the n>=0 metanotions W1, W2, ..., Wn is defined as L(HS) = {phi(H) | phi is a homomorphism with phi(v) = v for v in V and phi(Wi) in L((M, V, Rm, Wi)) for all 1<=i<=n}.

Definition 13. If HS=(M, V, Rm, H) is a hypernotion system with H = X1X2...Xn, Xi in (M u V) for 1<=i<=n, then HS is uniquely assignable (u.a.) if for all w in L(HS) there is exactly on partition (p1, p2, ..., pn) such that.  w = p1p2...pn and phi(Xi) = pi for phi homomorphism of Definition 12.
"
Class {
	#name : 'AFHypernotion',
	#superclass : 'Object',
	#instVars : [
		'notions',
		'metanotions',
		'metaGrammar',
		'grammar',
		'backwardCrossReferences',
		'forwardCrossReferences',
		'firstSet'
	],
	#category : 'FisherParser-Core-Implementation',
	#package : 'FisherParser-Core',
	#tag : 'Implementation'
}

{ #category : 'instance creation' }
AFHypernotion class >> belongsTo: aVWGrammar with: aNotion [
	^ (self with: aNotion)
		belongsTo: aVWGrammar;
		yourself
]

{ #category : 'instance creation' }
AFHypernotion class >> belongsTo: aVWGrammar withAll: aNotionCollection [
	^ (self withAll: aNotionCollection)
			belongsTo: aVWGrammar;
			yourself
]

{ #category : 'instance creation' }
AFHypernotion class >> belongsTo: aVWGrammar withAllNotionsFrom: anotherHypernotion [
	^ (self withAll: anotherHypernotion notions)
			belongsTo: aVWGrammar;
			yourself
]

{ #category : 'instance creation' }
AFHypernotion class >> empty [
	^ self new
]

{ #category : 'instance creation' }
AFHypernotion class >> new [
	^ self basicNew initializeNotions: #()
]

{ #category : 'instance creation' }
AFHypernotion class >> with: aNotion [
	^ self basicNew initializeNotions: (Array with: aNotion)
]

{ #category : 'instance creation' }
AFHypernotion class >> withAll: aNotionCollection [
	^ self basicNew
		initializeNotions: aNotionCollection;
		yourself
]

{ #category : 'comparing' }
AFHypernotion >> = anObject [

	self == anObject ifTrue: [ ^ true ].
	self class == anObject class ifFalse: [ ^ false ].
	self size == anObject size ifFalse: [ ^ false ].
	1 to: notions size do: [ :index |
		(notions at: index) = (anObject at: index) ifFalse: [ ^ false ] ].
	^ true
]

{ #category : 'cross references' }
AFHypernotion >> addBackwardCrossReference: anAFHyperRule [

	backwardCrossReferences add: anAFHyperRule
]

{ #category : 'cross references' }
AFHypernotion >> addForwardCrossReference: anAFHyperRule [
	forwardCrossReferences add: anAFHyperRule
]

{ #category : 'accessing' }
AFHypernotion >> apply: aSubstitution [
	^ (self class withAll: (notions collect: [ :notion | notion apply: aSubstitution ]))
		belongsTo: metaGrammar;
		backwardCrossReferences: backwardCrossReferences;
		forwardCrossReferences: forwardCrossReferences;
		yourself
]

{ #category : 'accessing' }
AFHypernotion >> asNonterminal [
	" must be a unique nonterminal "

	^ NCNonterminal named: (String streamContents: [ :s |
				   self isEmpty
					   ifTrue: [ s nextPutAll: '_empty_' ]
					   ifFalse: [ self printOn: s ].
				   s nextPut: $#.
				   self identityHash printOn: s ])
]

{ #category : 'accessing' }
AFHypernotion >> at: index [
	^ notions at: index
]

{ #category : 'cross references' }
AFHypernotion >> backwardCrossReferences: aHyperRuleCollection [

	backwardCrossReferences := aHyperRuleCollection
]

{ #category : 'cross references' }
AFHypernotion >> backwardCrossReferencesDo: aBlock [
	backwardCrossReferences do: aBlock
]

{ #category : 'accessing' }
AFHypernotion >> belongsTo: aMetaGrammar [

	metaGrammar := aMetaGrammar
]

{ #category : 'accessing' }
AFHypernotion >> buildBodyOf: symbols [
	"build body of symbols using those given as parameters"

	^ Array streamContents: [ :s |
			  notions do: [ :each |
					  each isMetanotion ifTrue: [
						  s nextPut: (symbols detect: [ :symbol | symbol = each ]) ].
					  each isProtonotion ifTrue: [
						  s nextPutAll: (each buildBodyOf: symbols) ].
					  each isTerminal ifTrue: [
						  s nextPut: (symbols detect: [ :symbol | symbol = each ]) ] ] ]
]

{ #category : 'testing' }
AFHypernotion >> checkIsLLOne [
	" page 14.
	The weaker version of P1 is: 
	R1. For each hypernotion h in the VWG, let h' denote the value of
		h after the following operation has been performed: for each
		metanotion m present in h, replace the second and subsequent
		ocurrences of m in h' consistently by some protonotion
		derivable from m. The VWG is acceptable only if the defining
		CFG of h' is LL(1), no matter which substitutions are chosen.
	R1 is easily checked. The standard algorithms all proceed by constructing
	'starter' and 'follower' sets for non-terminals in the CFG. To check R1,
	one applies one of the standard algorithms, but neglects to record followers
	for the second and subsequent occurrences of each metanotion. "

	| followSet parseTable conflictKeys |
	followSet := self computeFollowSet.
	parseTable := self computeParseTableUsing: followSet.
	conflictKeys := parseTable keys select: [ :key |
			                (metanotions includes: key first) and: [
				                (parseTable at: key) size > 1 ] ].
	conflictKeys isEmpty ifFalse: [
			Error signal: (String streamContents: [ :s |
						 s nextPutAll: 'CONFLICT at '.
						 conflictKeys
							 do: [ :key | s print: key ]
							 separatedBy: [ s space ] ]) ]
]

{ #category : 'accessing' }
AFHypernotion >> computeFirstSet [

	| previousSize |
	firstSet := MultiValuedDictionary
		            dictionary: IdentityDictionary
		            collection: IdentitySet.
	self grammar nonterminals do: [ :each |
		firstSet at: each putAll: #(  ) ].
	[
		previousSize := firstSet size.
		self grammar productionRules do: [ :rule |
			firstSet at: rule head putAll: (firstSet firstOf: rule body) ].
		previousSize = firstSet size ] whileFalse
]

{ #category : 'private' }
AFHypernotion >> computeFollowSet [

	| followSet previousSize previousNonterminals symbolFollowSet rest restFirstSet |
	followSet := MultiValuedDictionary
		             dictionary: IdentityDictionary
		             collection: IdentitySet.
	self grammar nonterminals do: [ :each |
		followSet at: each putAll: #(  ) ].
	followSet at: self grammar startSymbol put: #endmarker.
	[
		previousSize := followSet size.
		self grammar productionRules do: [ :rule |
				previousNonterminals := IdentitySet new.
				rule body withIndexDo: [ :symbol :index |
						(symbol isNonterminal and: [
							 (previousNonterminals includes: symbol) not ]) ifTrue: [
								previousNonterminals add: symbol.
								symbolFollowSet := IdentitySet new.
								rest := rule body allButFirst: index.
								rest isEmpty
									ifTrue: [ symbolFollowSet addAll: (followSet at: rule head) ]
									ifFalse: [
											restFirstSet := firstSet firstOf: rest.
											(restFirstSet includes: #epsilon) ifTrue: [
												symbolFollowSet addAll: (followSet at: rule head) ].
											symbolFollowSet addAll:
												(restFirstSet copyWithout: #epsilon) ].
								followSet at: symbol putAll: symbolFollowSet ] ] ].
		previousSize = followSet size ] whileFalse.
	^ followSet
]

{ #category : 'private' }
AFHypernotion >> computeParseTableUsing: followSet [
	" compute parse table using first set and follow test. 
	  then you can test if there's a conflict "

	| parseTable |
	parseTable := MultiValuedDictionary
		              dictionary: Dictionary
		              collection: IdentitySet.
	self grammar productionRules do: [ :rule |
			| bodyFirstSet |
			bodyFirstSet := firstSet firstOf: rule body.
			(self grammar terminals intersection: bodyFirstSet) do: [ :terminal |
					parseTable
						at: (OrderedPair first: rule head second: terminal)
						put: rule ].
			(bodyFirstSet includes: #epsilon) ifTrue: [
					(self grammar terminals intersection: (followSet at: rule head))
						do: [ :terminal |
								parseTable
									at: (OrderedPair first: rule head second: terminal)
									put: rule ] ] ].
	^ parseTable
]

{ #category : 'displaying' }
AFHypernotion >> displayStringOn: aStream [

	notions
		do: [ :each | each displayStringOn: aStream ]
		separatedBy: [ aStream space ]
]

{ #category : 'cross references' }
AFHypernotion >> forwardCrossReferences [
	^ forwardCrossReferences
]

{ #category : 'cross references' }
AFHypernotion >> forwardCrossReferences: aHyperRuleCollection [

	forwardCrossReferences := aHyperRuleCollection
]

{ #category : 'cross references' }
AFHypernotion >> forwardCrossReferencesDo: aBlock [
	forwardCrossReferences do: aBlock
]

{ #category : 'private' }
AFHypernotion >> grammar [
	^ grammar ifNil: [ grammar := metaGrammar startAt: self ]
]

{ #category : 'comparing' }
AFHypernotion >> hash [
	| hash |
	hash := self class hash.
	notions do: [ :each | hash := (hash + each hash) hashMultiply ].
	^ hash
]

{ #category : 'initialization' }
AFHypernotion >> initialize [

	super initialize.
	metanotions := Set new.
	backwardCrossReferences := Set new.
	forwardCrossReferences := Set new
]

{ #category : 'initialization' }
AFHypernotion >> initializeNotions: aNotionCollection [

	self initialize.
	notions := aNotionCollection.
	notions do: [ :each |
		each isMetanotion ifTrue: [ metanotions add: each ] ]
]

{ #category : 'inspector extensions' }
AFHypernotion >> inspectionBackwardCrossReferencesIn: builder [

	<inspectorPresentationOrder: 2 title: 'Backward X-Ref'>
	^ builder newList
		  items: backwardCrossReferences asArray;
		  display: [ :each | StObjectPrinter asTruncatedTextFrom: each ];
		  yourself
]

{ #category : 'inspector extensions' }
AFHypernotion >> inspectionForwardCrossReferencesIn: builder [

	<inspectorPresentationOrder: 1 title: 'Forward X-Ref'>
	^ builder newList
		  items: forwardCrossReferences asArray;
		  display: [ :each | StObjectPrinter asTruncatedTextFrom: each ];
		  yourself
]

{ #category : 'inspector extensions' }
AFHypernotion >> inspectionNotionsIn: builder [

	<inspectorPresentationOrder: 0 title: 'notions'>
	^ builder newList
		  items: notions;
		  display: [ :each | StObjectPrinter asTruncatedTextFrom: each ];
		  yourself
]

{ #category : 'testing' }
AFHypernotion >> isEmpty [
	^ notions isEmpty
]

{ #category : 'testing' }
AFHypernotion >> isHypernotion [
	^ notions isEmpty or: [ metanotions isNotEmpty ]
]

{ #category : 'testing' }
AFHypernotion >> isNonterminal [
	^ self isTerminal not
]

{ #category : 'testing' }
AFHypernotion >> isProtonotion [
	"its metanotion free"

	^ metanotions isEmpty and: [
			  notions isNotEmpty and: [
				  notions allSatisfy: [ :notion | notion isProtonotion ] ] ]
]

{ #category : 'testing' }
AFHypernotion >> isStrict [
	^ metanotions isEmpty
]

{ #category : 'testing' }
AFHypernotion >> isTerminal [
	^ metanotions isEmpty
		and: [ notions isNotEmpty and: [ notions allSatisfy: [ :notion | notion isTerminal ] ] ]
]

{ #category : 'matching' }
AFHypernotion >> match: aProtonotionHypernotion [
	"	a hypernotion match a protonotion, you need the relative substitution. "

	^ [ (self grammar parse: aProtonotionHypernotion asString) substitutionsOf: metanotions ]
		on: JEFailure
		do: [ AFSubstitution noSolution ]
]

{ #category : 'matching' }
AFHypernotion >> match: aProtonotionHypernotion do: aBlock [
	(self match: aProtonotionHypernotion) ifSolution: aBlock
]

{ #category : 'matching' }
AFHypernotion >> matchEmptyDo: aBlock [
	(self match: String empty) ifSolution: aBlock
]

{ #category : 'matching' }
AFHypernotion >> matches: aCharacter [

	^ notions first matches: aCharacter
]

{ #category : 'testing' }
AFHypernotion >> matchesEmpty [
	^ self grammar accepts: String empty
]

{ #category : 'accessing' }
AFHypernotion >> metanotions [
	^ metanotions
]

{ #category : 'testing' }
AFHypernotion >> occurrencesOf: aNotion [

	^ notions occurrencesOf: aNotion
]

{ #category : 'printing' }
AFHypernotion >> printOn: aStream [
	notions do: [ :each | each printOn: aStream ]
]

{ #category : 'printing' }
AFHypernotion >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]

{ #category : 'initialize-release' }
AFHypernotion >> release [
	notions := metanotions := metaGrammar := nil.
	grammar := backwardCrossReferences := forwardCrossReferences := firstSet := nil.
	super release
]

{ #category : 'accessing' }
AFHypernotion >> size [
	^ notions size
]

{ #category : 'accessing' }
AFHypernotion >> startFirstSet [
	^ firstSet at: self grammar startSymbol
]

{ #category : 'matching' }
AFHypernotion >> superMatches: anAFHypernotion [

	self = anAFHypernotion ifTrue: [ ^ true ].
	self isProtonotion ifTrue: [
		^ (anAFHypernotion match: self) isSolution ].
	anAFHypernotion isProtonotion ifTrue: [
		^ (self match: anAFHypernotion) isSolution ].
	^ (self startFirstSet intersection: anAFHypernotion startFirstSet)
		  isNotEmpty
]
