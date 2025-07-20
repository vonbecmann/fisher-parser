"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestAWijngaardenCore',
	#superclass : 'PackageManifest',
	#category : 'AWijngaarden-Core-Manifest',
	#package : 'AWijngaarden-Core',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestAWijngaardenCore class >> ruleReCompactSourceCodeRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#AWHyperRule #printOn: #false)) #'2025-07-20T02:21:19.997332-03:00') #(#(#RGMethodDefinition #(#AWMetaProductionRule #printOn: #false)) #'2025-07-20T02:21:19.997704-03:00') )
]
