"
An AFHyperAlternativeTest is a test class for testing the behavior of AFHyperAlternative
"
Class {
	#name : #AFHyperAlternativeTest,
	#superclass : #TestCase,
	#instVars : [
		'hyperAlternative'
	],
	#category : #'FisherParser-Tests-Implementation'
}

{ #category : #tests }
AFHyperAlternativeTest >> testDisplayStringOn [

	hyperAlternative := AFHyperAlternative with:
		                    (AFHypernotion withAll:
			                     #( 'i' #LETTER 's' ) asNotions).

	self assert: hyperAlternative displayString equals: 'i LETTER s'
]

{ #category : #tests }
AFHyperAlternativeTest >> testDisplayStringOn02 [

	hyperAlternative := AFHyperAlternative withAll: { 
			                    (AFHypernotion withAll: #( 'i' ) asNotions).
			                    (AFHypernotion withAll:
				                     #( 'i' #LETTER 's' ) asNotions) }.

	self assert: hyperAlternative displayString equals: 'i, i LETTER s'
]

{ #category : #tests }
AFHyperAlternativeTest >> testDisplayStringOn03 [

	hyperAlternative := AFHyperAlternative withAll: { 
			                    (AFHypernotion withAll:
				                     #( 'i' #LETTER 's' ) asNotions).
			                    (AFHypernotion withAll:
				                     #( #TALLY #LETTER 's' ) asNotions) }.

	self
		assert: hyperAlternative displayString
		equals: 'i LETTER s, TALLY LETTER s'
]

{ #category : #tests }
AFHyperAlternativeTest >> testDisplayStringOn04 [

	hyperAlternative := AFHyperAlternative with:
		                    (AFHypernotion withAll:
			                     #( #LETTER 'symbol' ) asNotions).

	self assert: hyperAlternative displayString equals: 'LETTER symbol'
]

{ #category : #tests }
AFHyperAlternativeTest >> testDisplayStringOn05 [

	hyperAlternative := AFHyperAlternative withAll: { 
			                    (AFHypernotion withAll:
				                     #( #THREE 'as' ) asNotions).
			                    (AFHypernotion withAll:
				                     #( #THREE 'bs' ) asNotions).
			                    (AFHypernotion withAll:
				                     #( #THREE 'cs' ) asNotions).
			                    (AFHypernotion withAll:
				                     #( 'stop' 'symbol' ) asNotions) }.

	self
		assert: hyperAlternative displayString
		equals: 'THREE as, THREE bs, THREE cs, stop symbol'
]
