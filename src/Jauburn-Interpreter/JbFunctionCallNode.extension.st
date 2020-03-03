Extension { #name : #JbFunctionCallNode }

{ #category : #'*Jauburn-Interpreter' }
JbFunctionCallNode >> evaluateIn: environment [ 

	| functionNode parms fun |
	functionNode := environment at: identifier.
	parms := arguments.

	fun := JbFunction new.
	

	fun environment: environment.
	fun environment: parms.

	^fun call: parms in: environment
	















"	| param funcNode func |
		funcNode := environment at: identifier.
		param := self arguments.

		func := JbFunction 
			newFromKeys: (self parameters collect: [ :each | each identifier ] ) 
			andValues: arguments.
		
		func outerEnvironment: self environment.
		
		body do: [ :each | each executeIn: func ]."
	
"		func body: funcNode body.
		func environment: environment.
		func parameters: funcNode parameters."

	


	
"	(funcNode parameters size = param size) ifTrue: [ ^func call: param in: environment. ] ifFalse: [ ^-1 ]"
	
	
"	proc := self evaluateIn: arguments.
	
fNode := environment at: identifier.
param := self arguments.

func := JbFunction new.

func body: fNode body.
func environment: environment.
func parameters: fNode parameters.

	(fNode parameters size = param size) ifTrue: [ ^func call: param in: environment. ] ifFalse: [ ^-1 ]"
]
