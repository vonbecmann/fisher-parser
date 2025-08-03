"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestFisherParserCore',
	#superclass : 'PackageManifest',
	#category : 'FisherParser-Core-Manifest',
	#package : 'FisherParser-Core',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestFisherParserCore class >> ruleCollectionProtocolRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#AFMetanotionSubstitutions #addAll: #false)) #'2025-08-03T14:45:23.266949-03:00') )
]

{ #category : 'code-critics' }
ManifestFisherParserCore class >> ruleReCompactSourceCodeRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#AFHyperRule #printOn: #false)) #'2025-08-03T11:16:54.347173-03:00') #(#(#RGMethodDefinition #(#AFDottedHyperRule #printOn: #false)) #'2025-08-03T11:16:54.347412-03:00') )
]
