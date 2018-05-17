Class {
	#name : #BaselineOfFisherParser,
	#superclass : #BaselineOf,
	#category : #BaselineOfFisherParser
}

{ #category : #baselines }
BaselineOfFisherParser >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ 
			spec
				baseline: 'EarleyParser'
				with: [ 
					spec
						repository: 'github://vonbecmann/earley-parser/repository';
						loads: #('Parser') ].
			spec
				package: 'AWijngaarden-Core';
				package: 'EarleyVW' with: [ spec requires: #('EarleyParser' 'AWijngaarden-Core') ];
				package: 'FisherParser-UI';
				package: 'AWijngaarden-Tests' with: [ spec requires: #('AWijngaarden-Core') ].
			spec
				group: 'default' with: #('Core' 'Tests' 'UI');
				group: 'Core' with: #('AWijngaarden-Core' 'EarleyVW');
				group: 'Tests' with: #('AWijngaarden-Tests');
				group: 'UI' with: #('FisherParser-UI');
				yourself ]
]
