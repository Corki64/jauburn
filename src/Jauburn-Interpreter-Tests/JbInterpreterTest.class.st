Class {
	#name : #JbInterpreterTest,
	#superclass : #TestCase,
	#instVars : [
		'interpreter',
		'parser',
		'transcript',
		'mt',
		'ph'
	],
	#category : #'Jauburn-Interpreter-Tests'
}

{ #category : #utilities }
JbInterpreterTest >> interpret: aString [

	| ast |
	ast :=  parser parse: aString.
	^interpreter interpret: ast.
	
]

{ #category : #tests }
JbInterpreterTest >> interpret: expression assertVar: var equals: value [

	self interpret: expression.
	self assert: (interpreter environment at: var) equals: value.
	
]

{ #category : #'as yet unclassified' }
JbInterpreterTest >> interpret: expression thenAssert: var equals: value [
	self interpret: expression.
	^ self assert: (interpreter environment at: var) equals: value
]

{ #category : #running }
JbInterpreterTest >> setUp [ 

	parser := JbParser new.
	interpreter := JbInterpreter new
]

{ #category : #test }
JbInterpreterTest >> testAbsBinding [

	self flag: #toImplement.
	self assert: false
]

{ #category : #running }
JbInterpreterTest >> testDeclarationBindsVariableToExpressionValue [

	self interpret: 'var x = 3 + 2 * 8;'.
	self assert: (interpreter environment at: 'x') equals: 19.
	
	self interpret: 'var x = 6;var y = 2*x;'.
	self assert: (interpreter environment at: 'y') equals: 12.
	
	self interpret: 'var x = 12; var y = x / 6;'.
	self assert: (interpreter environment at: 'y') equals: 2.
	
	self interpret: 'var x = 1; var y = x - 1;'.
	self assert: (interpreter environment at: 'y') equals: 0.
	self assert: (interpreter environment at: 'x') equals: 1.
	
	self interpret: 'var x = 20 - 10; var y = x / 2 + 9; var z = y * 10 / 14;'.
	self assert: (interpreter environment at: 'z') equals: 10.
	self assert: (interpreter environment at: 'x') equals: 10.
	self assert: (interpreter environment at: 'y') equals: 14.
	
]

{ #category : #running }
JbInterpreterTest >> testDeclarationCreatesVariable [

	self interpret: 'var x = 99;'.
	self assert: (interpreter environment includesKey: 'x')
]

{ #category : #tests }
JbInterpreterTest >> testEqualityOperators [
"test using JBArity2OperatorNode"
	
	self interpret: 'var x = 24 == 24;' assertVar: 'x' equals: true.
	self interpret: 'var x = 24 == 23;' assertVar: 'x' equals: false.
	
	self interpret: 'var x = 24 < 24;' assertVar: 'x' equals: false.
	self interpret: 'var x = 21 < 23;' assertVar: 'x' equals: true.
	
	self interpret: 'var x = 24 <= 24;' assertVar: 'x' equals: true.
	self interpret: 'var x = 24 <= 23;' assertVar: 'x' equals: false.
	self interpret: 'var x = 24 <= 30;' assertVar: 'x' equals: true.

	
	self interpret: 'var x = 24 > 24;' assertVar: 'x' equals: false.
	self interpret: 'var x = 24 > 23;' assertVar: 'x' equals: true.
	self interpret: 'var x = 24 > 20;' assertVar: 'x' equals: true.	
			
	self interpret: 'var x = 24 >= 24;' assertVar: 'x' equals: true.
	self interpret: 'var x = 24 >= 88;' assertVar: 'x' equals: false.
	self interpret: 'var x = 24 >= -8;' assertVar: 'x' equals: true.	
		
	self interpret: 'var x = 24 != 23;' assertVar: 'x' equals: true.
	self interpret: 'var x = 25 != 25;' assertVar: 'x' equals: false.
]

{ #category : #tests }
JbInterpreterTest >> testFunctionCallNode [

	self interpret: 'var x = 64; var y = function(a, b) { x = a + b;};'.
	self assert: (interpreter environment includesKey: 'y').
	self interpret: 'y(5,2);'.
	self assert: (interpreter environment at: 'x') equals: 7.
]

{ #category : #tests }
JbInterpreterTest >> testInputValue [

	| mockUI |
	interpreter uimanager: (mockUI := MockUIManager new).
	
	self interpret: 'input("hello")'.

	
	self assert: mockUI equals: 'hello'.
	
	
	

	interpreter uiManager: (mockUI := MockUIManager new).
	interpreter transcript: mockUI.
	mockUI interpret: 'input ("Type 42!");'.
	self assert: mockUI contents equals: '42'.
]

{ #category : #tests }
JbInterpreterTest >> testJbArity1OperatorNode [

	self interpret: 'var x = -99;'.
	self assert: (interpreter environment at: 'x') equals: -99.
	
	self interpret: 'var x = 99; var y = -x;'.
	self assert: (interpreter environment at: 'y') equals: -99.
	
	self interpret: 'var x = 6464; var y = x + 2537; var z = -y;'.
	self assert: (interpreter environment at: 'z') equals: -9001.
	
	self interpret: 'var x = 10; var y = 20; var z = -x; var q = -y; var final = z + q;'.
	self assert: (interpreter environment at: 'final') equals: -30.
]

{ #category : #tests }
JbInterpreterTest >> testJbArity2OperatorNode [

	self interpret: 'var x = 4 + 2 * 8 / 2 - 10;'.
	self assert: (interpreter environment at: 'x') equals: 2.
	
	self interpret: 'var x = 6 / 2; var y = 2 * x;'.
	self assert: (interpreter environment at: 'y') equals: 6.
	
	self interpret: 'var x = 12 - 2; var y = x / 6;'.
	self assert: (interpreter environment at: 'y') equals: 5/3.
	
	self interpret: 'var x = 1; var y = x - 1;'.
	self assert: (interpreter environment at: 'y') equals: 0.
	self assert: (interpreter environment at: 'x') equals: 1.
	
	self interpret: 'var x = 20 - 10; var y = x / 2 + 9; var z = y * 10 / 14;'.
	self assert: (interpreter environment at: 'z') equals: 10.
	self assert: (interpreter environment at: 'x') equals: 10.
	self assert: (interpreter environment at: 'y') equals: 14.
]

{ #category : #tests }
JbInterpreterTest >> testJbFunctionCall [

	
	self interpret: 'var y = function(p, q) { return p + q };'.
	self interpret: 'var z = y(2 , 2);' thenAssert: 'y'  equals: 4. 
]

{ #category : #tests }
JbInterpreterTest >> testJbIfElseNodeFunctions [

	self interpret: 'var y = true;'.
	self interpret: 'if (y) { var x = 5;};'.
	
	self assert: (interpreter environment at: 'x') equals: 5.
	
"""	self interpret: 'var x = 10;'.
	self interpret: 'var y = 20;'.
	self interpret: 'if (y == 10) { var z = 6; };'.
	self assert: (interpreter environment at: 'z') equals: 6."
]

{ #category : #tests }
JbInterpreterTest >> testJbIfNodeFunctions [

	self interpret: 'var y = true;'.
	self interpret: 'if (y) { var x = 5;}'.
	
	self assert: (interpreter environment at: 'x') equals: 5.
]

{ #category : #test }
JbInterpreterTest >> testLengthBinding [

	self flag: #toImplement.
	self assert: false
]

{ #category : #test }
JbInterpreterTest >> testModBinding [

	self interpret: 'var x = 12 mod 6;' assertVar: 'x' equals: 0.
	
"	self interpret: 'var x = 12mod6'"
]

{ #category : #tests }
JbInterpreterTest >> testNotBinding [

	self interpret: 'var y = not(true);' assertVar: 'y' equals: false.
]

{ #category : #tests }
JbInterpreterTest >> testPrintBinding [

	self interpret: 'print"Hello";'.
	
	mt := MockTranscript new.

	
	self interpret: 'var x = print(42);' assertVar: 'x' equals: '42'.
	
"	ph parseAndEval: '(print 42)'.
	self assert: mt contents equals: '42'.
	ph parseAndEval: '(print 75)'.
	self assert: mt contents equals: '4275'.
	ph parseAndEval: '(print true)'.
	self assert: mt contents equals: '4275true'.
	ph parseAndEval: '(print (str (quote (this is a list))))'.
	self assert: mt contents equals: '4275truethis is a list'."
]
