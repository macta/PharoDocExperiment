Class {
	#name : #UKSmalltalk,
	#superclass : #Object,
	#category : #UKS
}

{ #category : #processing }
UKSmalltalk >> classesFor: class to: output [
	^ (class subclasses asSortedCollection: [ :a :b | a name < b name ])
		do: [ :each | output nextPutAll: (self linkTo: each name) ]
		separatedBy: [ output nextPutAll: '</br>' ]
]

{ #category : #processing }
UKSmalltalk >> linkTo: className [

	^'<a href="/class/{1}">{1}</a>' format: { className }
]

{ #category : #processing }
UKSmalltalk >> methodsFor: class to: output [
	^ (class methods asSortedCollection: [ :a :b | a name < b name ])
		do: [ :each | output nextPutAll: (self linkTo: class name, '/', each selector urlEncoded ) ]
		separatedBy: [ output nextPutAll: '</br>' ]
]

{ #category : #processing }
UKSmalltalk >> pre: comment [
	^ '<pre>' , comment , '</pre>'
]

{ #category : #processing }
UKSmalltalk >> process: aRequest [
	| className class |
	^ String
		streamContents: [ :output | 
			className := (aRequest at: #name) asSymbol.
			class := Smalltalk at: className.
			output
				nextPutAll: (self linkTo: className);
				nextPutAll: (self pre: class comment).
			self 
				methodsFor: class to: output;
			 	classesFor: class to: output ]
]

{ #category : #processing }
UKSmalltalk >> processWithMethod: aRequest [
	| className class methodName |
	^ String
		streamContents: [ :output | 
			className := (aRequest at: #name) asSymbol.
			methodName := (aRequest at: #method) asSymbol.
			class := Smalltalk at: className.
			output
				nextPutAll: (self linkTo: className);
				nextPutAll: (self pre: (class methodNamed: methodName) comment).
			 ]
]
