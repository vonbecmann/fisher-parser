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
				package: 'AWijngaarden-Core';
				package: 'AWijngaarden-Tests' with: [ spec requires: #('AWijngaarden-Core') ].
			spec
				group: 'default' with: #('AWijngaarden-Core');
				group: 'Tests' with: #('AWijngaarden-Tests');
				yourself ]
]