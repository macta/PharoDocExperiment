Class {
	#name : #BaselineOfUKS,
	#superclass : #BaselineOf,
	#category : #UKS
}

{ #category : #baseline }
BaselineOfUKS >> baseline: spec [
	<baseline>
	
	spec
		for: #common
		do: [ 
			self setUpDependencies: spec.
			spec 
				package: 'UKS' 
					with: [ spec requires: #('Teapot') ] ]
]

{ #category : #baseline }
BaselineOfUKS >> setUpDependencies: spec [

	spec
		baseline: 'Teapot'
			with: [ spec
				repository: 'github://zeroflag/Teapot:v{XX}/source';
				loads: #('Deployment') ];
		import: 'Teapot'.
]
