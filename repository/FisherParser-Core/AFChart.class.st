"
chart that hold the columns.

"
Class {
	#name : 'AFChart',
	#superclass : 'Object',
	#instVars : [
		'columns'
	],
	#category : 'FisherParser-Core-Implementation',
	#package : 'FisherParser-Core',
	#tag : 'Implementation'
}

{ #category : 'instance creation' }
AFChart class >> numberOfColumns: numberOfColumns withStartHyperRule: startHyperRule [
	^ self basicNew
		initializeColumns:
			{(AFColumn numberOneWithDottedHyperRule: startHyperRule dotAtBeginning)}
				, ((2 to: numberOfColumns) collect: [ :index | AFColumn number: index ]);
		yourself
]

{ #category : 'accessing' }
AFChart >> at: index [
	^ columns at: index
]

{ #category : 'testing' }
AFChart >> columnSizes [
	^ columns collect: [ :each | each size ]
]

{ #category : 'accessing' }
AFChart >> first [
	^ columns first
]

{ #category : 'initialization' }
AFChart >> initializeColumns: arrayOfColumns [
	columns := arrayOfColumns
]

{ #category : 'inspector extensions' }
AFChart >> inspectionAllSortedItemsAtColumnsIn: aBuilder [

	<inspectorPresentationOrder: 1 title: 'all sorted items'>
	^ aBuilder newTable
		  addColumn: (SpStringTableColumn new
				   title: '[start, end]';
				   evaluated: [ :each | each displayIntervalString ];
				   width: 70;
				   yourself);
		  addColumn: (SpStringTableColumn
				   title: 'Value'
				   evaluated: [ :each | each displayString ]);
		  items: (OrderedCollection
				   new:
				   (columns inject: 0 into: [ :sum :column | sum + column size ])
				   streamContents: [ :s |
				   columns do: [ :column | s nextPutAll: column sortedItems ] ]);
		  yourself
]

{ #category : 'inspector extensions' }
AFChart >> inspectionColumnBrowserIn: composite [

	<gtInspectorPresentationOrder: 1>
	^ composite tabulator
		  with: [ :tab |
				  tab title: 'browse'.
				  columns do: [ :column |
							  tab column: column asString asSymbol.
							  tab transmit
								  to: column asString asSymbol;
								  andShow: [ :a |
										  a fastList
											  display: [ column sortedItems ];
											  format: [ :each |
												  StObjectPrinter asTruncatedTextFrom: each ];
											  yourself ] ] ];
		  yourself
]

{ #category : 'inspector extensions' }
AFChart >> inspectionColumnsIn: aBuilder [

	<inspectorPresentationOrder: 2 title: 'Columns'>
	^ aBuilder newList
		  display: [ :each | StObjectPrinter asTruncatedTextFrom: each ];
		  items: columns;
		  yourself
]

{ #category : 'accessing' }
AFChart >> last [
	^ columns last
]

{ #category : 'printing' }
AFChart >> printOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPut: $(;
		print: columns size;
		nextPutAll: ' columns)'
]

{ #category : 'printing' }
AFChart >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]

{ #category : 'initialize-release' }
AFChart >> release [
	columns := nil.
	super release
]

{ #category : 'accessing' }
AFChart >> size [
	^ columns size
]

{ #category : 'enumerating' }
AFChart >> withIndexDo: elementAndIndexBlock [

	columns withIndexDo: elementAndIndexBlock
]
