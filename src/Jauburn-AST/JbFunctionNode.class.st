Class {
	#name : #JbFunctionNode,
	#superclass : #Object,
	#instVars : [
		'body',
		'parameters',
		'identifier',
		'arguments'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #accessing }
JbFunctionNode >> arguments [
	^ arguments
]

{ #category : #accessing }
JbFunctionNode >> arguments: anObject [
	arguments := anObject
]

{ #category : #accessing }
JbFunctionNode >> body [
	^ body
]

{ #category : #accessing }
JbFunctionNode >> body: anObject [
	body := anObject
]

{ #category : #accessing }
JbFunctionNode >> identifier [
	^ identifier
]

{ #category : #accessing }
JbFunctionNode >> identifier: anObject [
	identifier := anObject
]

{ #category : #accessing }
JbFunctionNode >> parameters [
	^ parameters
]

{ #category : #accessing }
JbFunctionNode >> parameters: anObject [
	parameters := anObject
]
