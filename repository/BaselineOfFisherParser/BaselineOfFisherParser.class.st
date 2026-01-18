Class {
	#name : 'BaselineOfFisherParser',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfFisherParser',
	#package : 'BaselineOfFisherParser'
}

{ #category : 'baselines' }
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
				package: 'AWijngaarden-Core'
					 with: [ spec requires: #('EarleyParser') ];
				package: 'AWijngaarden-Tests' with: [ spec requires: #('AWijngaarden-Core') ];
				package: 'EarleyVW' with: [ spec requires: #('EarleyParser' 'AWijngaarden-Core') ];
				package: 'EarleyVW-Tests' with: [ spec requires: #('EarleyVW') ];
				package: 'FisherParser-Core'
					with: [ spec requires: #('AWijngaarden-Core' 'EarleyVW') ];
				package: 'FisherParser-Tests' 
					with: [ spec requires: #('FisherParser-Core') ];
				package: 'FisherParser-UI'.
			spec
				group: 'default' with: #('Core' 'Tests' 'UI');
				group: 'Core' with: #('AWijngaarden-Core' 'EarleyVW' 'FisherParser-Core');
				group: 'Tests' with: #('AWijngaarden-Tests' 'EarleyVW-Tests' 'FisherParser-Tests');
				group: 'UI' with: #('FisherParser-UI');
				yourself ]
]
