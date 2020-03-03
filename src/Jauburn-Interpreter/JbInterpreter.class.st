"
I am an interpreter for programs written in the Jauburn language.  My principle API methods are:

	interpret: anAST -- given an abstract syntax tree, interpret it
	run: aString -- parse and interpret the supplied string
"
Class {
	#name : #JbInterpreter,
	#superclass : #Object,
	#instVars : [
		'environment',
		'uimanager',
		'transcript'
	],
	#category : #'Jauburn-Interpreter-Core'
}

{ #category : #primitives }
JbInterpreter >> absBinding [
	^ #abs -> [ :value |  self abs value ]
	


]

{ #category : #primitives }
JbInterpreter >> concatBinding [
	^ #concat -> [ :value |  Transcript show: value printString; cr ]
]

{ #category : #accessing }
JbInterpreter >> environment [ 

	^environment
]

{ #category : #accessing }
JbInterpreter >> environment: anObject [
	environment := anObject
]

{ #category : #initialization }
JbInterpreter >> initialize [ 

	super initialize.
	environment := JbEnvironment new.
	self initializeBindings.
]

{ #category : #initialization }
JbInterpreter >> initializeBindings [

	| primitive |
	
	
	(self class selectors select: [ :each | each endsWith: 'Binding' ])
		
		do: [ :ea 	| 
				| binding |
				
				binding := self perform: ea.
				primitive := JbPrimitive new.
				primitive block: binding value.
				environment at: binding key put: primitive ]
]

{ #category : #primitives }
JbInterpreter >> inputBinding [

	^#input -> [ :prompt | uimanager  request: prompt asString ]
]

{ #category : #api }
JbInterpreter >> interpret: ast [

	^ast executeIn: environment 
]

{ #category : #primitives }
JbInterpreter >> lengthBinding [

	^#length -> [ :value |
		value size.
		 ]
]

{ #category : #primitives }
JbInterpreter >> modBinding [
	^ #mod -> [ :a :b |  a mod: b ]
	


]

{ #category : #primitives }
JbInterpreter >> notBinding [

	^#not -> [ :x | x not. ]
]

{ #category : #primitives }
JbInterpreter >> printBinding [
	^ #print -> [ :value |  self transcript show: value asString ]
	


]

{ #category : #primitives }
JbInterpreter >> printlnBinding [
	
	^ #println -> [ :value |  Transcript show: value printString, Transcript cr ]
]

{ #category : #api }
JbInterpreter >> run: programString [

	| parser |
	parser := JbParser new.
	self interpret: (parser parse: programString)
]

{ #category : #accessing }
JbInterpreter >> transcript [

	^transcript ifNil: [ Transcript  ]
]

{ #category : #accessing }
JbInterpreter >> transcript: aTranscript [

	transcript := aTranscript
]

{ #category : #accessing }
JbInterpreter >> uimanager [

	^uimanager ifNil: [ UIManager default ]
]

{ #category : #accessing }
JbInterpreter >> uimanager: anObject [
	uimanager := anObject
]
