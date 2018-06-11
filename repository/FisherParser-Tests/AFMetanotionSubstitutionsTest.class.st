Class {
	#name : #AFMetanotionSubstitutionsTest,
	#superclass : #TestCase,
	#category : #'FisherParser-Tests-MetaMatching'
}

{ #category : #tests }
AFMetanotionSubstitutionsTest >> testAdd [
	| metanotionSubtitutions |
	metanotionSubtitutions := AFMetanotionSubstitutions new.
	self assert: metanotionSubtitutions size equals: 0.

	metanotionSubtitutions add: (AWMetanotion named: 'LETTER') -> (AWProtonotion with: 'a').
	self assert: metanotionSubtitutions size equals: 1.

	metanotionSubtitutions add: (AWMetanotion named: 'LETTER') -> (AWProtonotion with: 'a').
	self assert: metanotionSubtitutions size equals: 1
]

{ #category : #tests }
AFMetanotionSubstitutionsTest >> testAdd02 [
	| metanotionSubtitutions |
	metanotionSubtitutions := AFMetanotionSubstitutions new.
	self assert: metanotionSubtitutions size equals: 0.

	metanotionSubtitutions add: (AWMetanotion named: 'LETTER') -> (AWProtonotion with: 'a').
	self assert: metanotionSubtitutions size equals: 1.

	metanotionSubtitutions add: (AWMetanotion named: 'LETTER') -> (AWProtonotion with: 'b').
	self assert: metanotionSubtitutions size equals: 2
]

{ #category : #tests }
AFMetanotionSubstitutionsTest >> testAddAll [
	| metanotionSubtitutions |
	metanotionSubtitutions := AFMetanotionSubstitutions new.
	self assert: metanotionSubtitutions size equals: 0.

	metanotionSubtitutions 
		addAll: {(AWMetanotion named: 'LETTER') -> (AWProtonotion with: 'a').
					(AWMetanotion named: 'LETTER') -> (AWProtonotion with: 'b')}.
	self assert: metanotionSubtitutions size equals: 2
]

{ #category : #tests }
AFMetanotionSubstitutionsTest >> testAddAll02 [
	| metanotionSubtitutions |
	metanotionSubtitutions := AFMetanotionSubstitutions new.
	self assert: metanotionSubtitutions size equals: 0.

	metanotionSubtitutions 
		addAll: {(AWMetanotion named: 'LETTER') -> (AWProtonotion with: 'a').
					(AWMetanotion named: 'LETTER') -> (AWProtonotion with: 'a')}.
	self assert: metanotionSubtitutions size equals: 1
]

{ #category : #tests }
AFMetanotionSubstitutionsTest >> testAsString [
	self 
		assert: AFMetanotionSubstitutions empty asString
		equals: '{}'
]

{ #category : #tests }
AFMetanotionSubstitutionsTest >> testAsString02 [
	self
		assert:
			(AFMetanotionSubstitutions new
				add: (AWMetanotion named: 'LETTER') -> (AWProtonotion with: 'a');
				yourself) asString
		equals: '{LETTER->a}'
]

{ #category : #tests }
AFMetanotionSubstitutionsTest >> testAsString03 [
	self
		assert:
			(AFMetanotionSubstitutions new
				add: (AWMetanotion named: 'LETTER') -> (AWProtonotion with: 'a');
				add: (AWMetanotion named: 'NOTION') -> (AWProtonotion with: 'hij');
				yourself) asString
		equals: '{LETTER->a, NOTION->hij}'
]
