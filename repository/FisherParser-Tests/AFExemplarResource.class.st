"
grammar examples as a test resource
"
Class {
	#name : #AFExemplarResource,
	#superclass : #TestResource,
	#instVars : [
		'a3b3c3',
		'starSequence',
		'anbncn',
		'test3',
		'anbn',
		'wegner',
		'test4',
		'test15',
		'test5',
		'doubleLettersB',
		'doubleLettersC',
		'pl',
		'leftRecursiveAnbncn',
		'anbncndnen'
	],
	#category : #'FisherParser-Tests-Grammar'
}

{ #category : #accessing }
AFExemplarResource >> a3b3c3 [
	^ a3b3c3
]

{ #category : #accessing }
AFExemplarResource >> anbn [
	^ anbn
]

{ #category : #accessing }
AFExemplarResource >> anbncn [
	^ anbncn
]

{ #category : #accessing }
AFExemplarResource >> anbncndnen [

	^ anbncndnen
]

{ #category : #accessing }
AFExemplarResource >> doubleLettersB [
	^ doubleLettersB
]

{ #category : #accessing }
AFExemplarResource >> doubleLettersC [
	^ doubleLettersC
]

{ #category : #accessing }
AFExemplarResource >> leftRecursiveAnbncn [
	^ leftRecursiveAnbncn
]

{ #category : #accessing }
AFExemplarResource >> pl [
	^ pl
]

{ #category : #running }
AFExemplarResource >> setUp [

	super setUp.
	a3b3c3 := AFExemplar a3b3c3.
	starSequence := AFExemplar starSequence.
	anbncn := AFExemplar anbncn.
	test3 := AFExemplar test3.
	anbn := AFExemplar anbn.
	wegner := AFExemplar wegner.
	test4 := AFExemplar test4.
	test15 := AFExemplar test15.
	test5 := AFExemplar test5.
	doubleLettersB := AFExemplar doubleLettersB.
	doubleLettersC := AFExemplar doubleLettersC.
	pl := AFExemplar pl.
	leftRecursiveAnbncn := AFExemplar leftRecursiveAnbncn.
	anbncndnen := AFExemplar anbncndnen
]

{ #category : #accessing }
AFExemplarResource >> starSequence [
	^ starSequence
]

{ #category : #running }
AFExemplarResource >> tearDown [

	"Does nothing. Subclasses should override this to tear down their resource"

	a3b3c3 := starSequence := anbncn := test3 := anbn := nil.
	wegner := test4 := test15 := test5 := doubleLettersB := nil.
	doubleLettersC := pl := leftRecursiveAnbncn := nil.
	anbncndnen := nil.
	super tearDown
]

{ #category : #accessing }
AFExemplarResource >> test15 [
	^ test15
]

{ #category : #accessing }
AFExemplarResource >> test3 [
	^ test3
]

{ #category : #accessing }
AFExemplarResource >> test4 [
	^ test4
]

{ #category : #accessing }
AFExemplarResource >> test5 [
	^ test5
]

{ #category : #accessing }
AFExemplarResource >> wegner [
	^ wegner
]
