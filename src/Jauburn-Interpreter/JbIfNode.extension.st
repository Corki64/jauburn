Extension { #name : #JbIfNode }

{ #category : #'*Jauburn-Interpreter' }
JbIfNode >> executeIn: anEvironment [

	| val |
	
	val := condition evaluateIn: anEvironment.
	
	val ifTrue: [ self trueStatements do: [ :stmt | stmt executeIn: anEvironment  ] ]
]
