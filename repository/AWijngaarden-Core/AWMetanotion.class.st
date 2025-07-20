"
a metanotion is a non-empty sequence of large syntactic marks that is defined in the metaproductions. (e.g., *ALPHA*)
However, care must be taken in choosing the metanotions so that any sequence of metanotions is no also a different sequence of metanotions. For example, if *A* and *B* are metanotions then *AB* should not be a third metanotion; otherwise unintended ambiguity may arise.

- ""large syntactic marks"" as $A-$Z, $0-$9.

a metanotion is a nonterminal of the meta level of a vw-grammar.
"
Class {
	#name : 'AWMetanotion',
	#superclass : 'NCNonterminal',
	#category : 'AWijngaarden-Core',
	#package : 'AWijngaarden-Core'
}

{ #category : 'testing' }
AWMetanotion >> isMetanotion [
	^ true
]

{ #category : 'testing' }
AWMetanotion >> isProtonotion [
	^ false
]
