Class {
	#name : #MockUIManager,
	#superclass : #Object,
	#instVars : [
		'request'
	],
	#category : #'Jauburn-Interpreter-Tests'
}

{ #category : #accessing }
MockUIManager >> request [
	^ request asString
]

{ #category : #accessing }
MockUIManager >> request: anObject [
	request := anObject
]
