Class {
	#name : #AFMetanotionSubstitutionsTest,
	#superclass : #TestCase,
	#category : #'FisherParser-Tests-MetaMatching'
}

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
