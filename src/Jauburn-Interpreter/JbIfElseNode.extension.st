Extension { #name : #JbIfElseNode }

{ #category : #'*Jauburn-Interpreter' }
JbIfElseNode >> executeIn: environment [ 
	
	| bool |
	
	bool := condition evaluateIn: environment.
	
	bool ifTrue: [ self trueStatements do: [ :stmt | stmt executeIn: environment ] ]
		  ifFalse: [ self falseStatements  do: [ :stmt | stmt evaluateIn: environment ] ]
]
