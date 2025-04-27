"
a tree parser
extract the single tree in the forest
"
Class {
	#name : 'AFTreeParser',
	#superclass : 'AFParser',
	#category : 'FisherParser-Core-Implementation',
	#package : 'FisherParser-Core',
	#tag : 'Implementation'
}

{ #category : 'parsing' }
AFTreeParser >> parse: words [
	| forest |
	forest := super parse: words.
	self assert: forest isAmbiguous not.
	^ forest extractSingleParseTree
]
