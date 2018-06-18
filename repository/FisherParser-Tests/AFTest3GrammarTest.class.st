"
test3 grammar
"
Class {
	#name : #AFTest3GrammarTest,
	#superclass : #AFGrammarTest,
	#category : #'FisherParser-Tests-Grammar'
}

{ #category : #running }
AFTest3GrammarTest >> setUp [
	super setUp.
	grammar := self examples test3
]

{ #category : #tests }
AFTest3GrammarTest >> testAcceptsHHH [
	self assert: (grammar accepts: 'hhh')
]

{ #category : #tests }
AFTest3GrammarTest >> testAcceptsHHI [
	self deny: (grammar accepts: 'hhi')
]

{ #category : #tests }
AFTest3GrammarTest >> testAcceptsHHJ [
	self deny: (grammar accepts: 'hhj')
]

{ #category : #tests }
AFTest3GrammarTest >> testAcceptsHIH [
	self deny: (grammar accepts: 'hih')
]

{ #category : #tests }
AFTest3GrammarTest >> testAcceptsHII [
	self deny: (grammar accepts: 'hii')
]

{ #category : #tests }
AFTest3GrammarTest >> testAcceptsHJH [
	self deny: (grammar accepts: 'hjh')
]

{ #category : #tests }
AFTest3GrammarTest >> testAcceptsHJJ [
	self deny: (grammar accepts: 'hjj')
]

{ #category : #tests }
AFTest3GrammarTest >> testAcceptsIHH [
	self deny: (grammar accepts: 'ihh')
]

{ #category : #tests }
AFTest3GrammarTest >> testAcceptsIHI [
	self deny: (grammar accepts: 'ihi')
]

{ #category : #tests }
AFTest3GrammarTest >> testAcceptsIIH [
	self deny: (grammar accepts: 'iih')
]

{ #category : #tests }
AFTest3GrammarTest >> testAcceptsIII [
	self assert: (grammar accepts: 'iii')
]

{ #category : #tests }
AFTest3GrammarTest >> testAcceptsIIJ [
	self deny: (grammar accepts: 'iij')
]

{ #category : #tests }
AFTest3GrammarTest >> testAcceptsIJI [
	self deny: (grammar accepts: 'iji')
]

{ #category : #tests }
AFTest3GrammarTest >> testAcceptsIJJ [
	self deny: (grammar accepts: 'ijj')
]

{ #category : #tests }
AFTest3GrammarTest >> testAcceptsJHH [
	self deny: (grammar accepts: 'jhh')
]

{ #category : #tests }
AFTest3GrammarTest >> testAcceptsJHJ [
	self deny: (grammar accepts: 'jhj')
]

{ #category : #tests }
AFTest3GrammarTest >> testAcceptsJII [
	self deny: (grammar accepts: 'jii')
]

{ #category : #tests }
AFTest3GrammarTest >> testAcceptsJIJ [
	self deny: (grammar accepts: 'jij')
]

{ #category : #tests }
AFTest3GrammarTest >> testAcceptsJJH [
	self deny: (grammar accepts: 'jjh')
]

{ #category : #tests }
AFTest3GrammarTest >> testAcceptsJJI [
	self deny: (grammar accepts: 'jji')
]

{ #category : #tests }
AFTest3GrammarTest >> testAcceptsJJJ [
	self assert: (grammar accepts: 'jjj')
]
