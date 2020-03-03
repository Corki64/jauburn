Extension { #name : #JbFunctionNode }

{ #category : #'*Jauburn-Interpreter' }
JbFunctionNode >> evaluateIn: environment [
	| functionNode parms fun |
	functionNode := environment at: identifier.
	parms := self arguments.
	fun := JbFunction new.
	fun body: body evaluateIn: environment.
	fun environment: environment.
	fun parameters: functionNode parameters.
	^ fun call: parms in: environment
]

{ #category : #'*Jauburn-Interpreter' }
JbFunctionNode >> executeIn: environment [  

	^self evaluateIn: environment
]
