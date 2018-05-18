Class {
	#name : #AFisherUI,
	#superclass : #Object,
	#category : #'FisherParser-UI'
}

{ #category : #environment }
AFisherUI class >> fisherEnvironment [
	| baseline packageNames |
	baseline := BaselineOfFisherParser.
	packageNames := OrderedCollection with: baseline package packageName.
	packageNames addAll: (baseline project version packages collect: [ :each | each name ]).
	^ (RBBrowserEnvironment new forPackageNames: packageNames)
		label: 'Fisher Parser Environment';
		yourself
]

{ #category : #'menu declaration' }
AFisherUI class >> fisherToolsOn: aBuilder [
	<worldMenu>
	(aBuilder group: #FisherTools)
		withSeparatorAfter;
		order: 1;
		with: 
			[ (aBuilder item: #Fisher)
				with: 
				[ (aBuilder item: #FisherBrowser)
						label: 'System Browser';
						action: [ self openBrowserInFisherEnvironment ];
						icon: Smalltalk tools browser taskbarIcon.
					(aBuilder item: #Workspace)
						label: 'Workspace';
						action: [ Workspace open ] ] ]
]

{ #category : #environment }
AFisherUI class >> openBrowserInFisherEnvironment [
	^ (Smalltalk tools browser browsedEnvironment: self fisherEnvironment) open
]