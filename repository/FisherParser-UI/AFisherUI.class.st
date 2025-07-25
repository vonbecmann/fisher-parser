"
build fisher's tools in world.

"
Class {
	#name : 'AFisherUI',
	#superclass : 'Object',
	#category : 'FisherParser-UI',
	#package : 'FisherParser-UI'
}

{ #category : 'environment' }
AFisherUI class >> fisherEnvironment [
	| baseline packages |
	baseline := BaselineOfFisherParser.
	packages := OrderedCollection with: baseline package.
	packages
		addAll:
			(baseline allPackageNames
				collect: [ :each | self package organizer packageNamed: each ]).
	^ packages
]

{ #category : 'menu declaration' }
AFisherUI class >> fisherToolsOn: aBuilder [

	<worldMenu>
	(aBuilder group: #FisherTools)
		order: 0.99;
		withSeparatorAfter;
		with: [
				(aBuilder item: #'Fisher Tools') with: [
							(aBuilder item: #FisherBrowser)
								label: 'System Browser';
								action: [ self openBrowserInFisherEnvironment ];
								icon: (Smalltalk tools browser iconNamed:
											 Smalltalk tools browser taskbarIconName) ] ]
]

{ #category : 'environment' }
AFisherUI class >> openBrowserInFisherEnvironment [
	^ Smalltalk tools browser
		openWithState: [ :browser | browser switchToPackageScopeOf: self fisherEnvironment ]
]
