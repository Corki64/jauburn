Class {
	#name : #MockTranscript,
	#superclass : #Object,
	#instVars : [
		'contents'
	],
	#category : #'Jauburn-Interpreter-Tests'
}

{ #category : #accessing }
MockTranscript >> contents [ 
	
	^contents
]

{ #category : #accessing }
MockTranscript >> initialize [

	contents := ''
]

{ #category : #accessing }
MockTranscript >> show: object [ 

	contents := contents, object
]
