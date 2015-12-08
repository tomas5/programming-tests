/*
#######################
### JavaScript Test ###
#######################
*/

//-------------------------------------------------------------------

// Which of the following is the correct way to append a value to an array in JavaScript?

// 1.
arr[arr.length - 1] = value

// 2.
arr.insert(value)

// 3.
arr.insert(arr.length, value)

// 4.
arr[arr.length + 1] = new Arrays(value)

// 5.
arr.add(value)

// 6.
arr[arr.length] = value

// 7.
None of the above

//-------------------------------------------------------------------

// Which of the following would be the correct way to read the "age" property of a "person" object?

// 1.
person['age']

// 2.
person.age

// 3.
person::age

// 4.
person[age]

//-------------------------------------------------------------------

// What is the output of the following script?

function fs() {
	var pre = 1;
	alert(pre);
}

fs();

// Answer: => 1

//-------------------------------------------------------------------

// What is the output of the following script?

<script type="text/javascript">
	function fs() {
    	var pre = 1;
</script>

<script type="text/javascript">
		alert(pre);
	}
	fs();
</script>

// Options:
// 1.	0
// 2.	1
// 3.	Nothing the script is not correct

// Answer: JavaScript error: Uncaught SyntaxError: Unexpected token } on line 3

//-------------------------------------------------------------------

// Consider the following code:

<script type="text/javascript">
	function Test(param) {
		this.var1 = param;
		varvar2 = 'World';
	}

	var test = new Test('Hello');

	var a = test.var1;

	var b = test.var2;
</script>

// What will be the value of "a" and "b"?

// 1.	a=undefined, b='Word'
// 2.	a='Hello', b=undefined
// 3.	a='Hello', b='World'
// 4.	a=undefined, b=undefiend

// Answer: 2. a='Hello', b=undefined

//-------------------------------------------------------------------

// Which of the following would be the correct way to define and invoke a method that will display the "FirstName" property of a "person" object?

// 1.
person.ShowName = Function.Create({alert(FirstName);});
person.ShowName();

// 2.
person.ShowName = new function() { alert(FirstName); }
person.ShowName();

// 3.
person.ShowName = function(sender) { alert(sender.FirstName); }
person.ShowName();

// 4.
person.ShowName = function() { alert(this.FirstName); }
person.ShowName();

// 5.
person.ShowName = function() { alert(sender.FirstName); }
person.ShowName();

// 6.
// You cannot define a method for the object in JavaScript

//-------------------------------------------------------------------

// Which of the following are valid ways to create an object in JavaScript ?

// 1.
var person = mew Object();
person.FirstName = "John";
person.LastName = "Smith";

// 2.
var person = { FirstName = "John", LastName = "Smith" };

// 3.
var person = { "FirstName": "John", "LastName": "Smith" };

// 4.
var person = new Object( FirstName = "John", LastName = "Smith" );

// 5.
var person = new { FirstName = "John", LastName = "Smith" };

// 6.
var person = { FirstName: "John", LastName: "Smith" };

//-------------------------------------------------------------------

// Consider the following code:
<script type="text/javascript">

	function square(x) {
		return x * x;
	}

	var b = square;

	var result = b(3);

</script>

// What will be the value of "result" ?

// 1.	0
// 2.	9
// 3.	3
// 4.	Nothing, the script is not correct.

// Answer: => 9 

//-------------------------------------------------------------------

// Which of the following can be used to handle the user clicking on a node?

// 1.
node.addEventListener("onclick", myFunction, false)

// 2.
node.onclick(myFunction)

// 3.
node.attachEvent("onclick", myFunction)

// 4.
node.addEventListener("click", myFunction, false)

//-------------------------------------------------------------------

// Consider the following HTML:

<a id="link" href="http://yahoo.com">The Link</a>

// Which of the following code snippets would change the "href" of the above link to "http://google.com" ?

// 1.
document.getElementById("link").href = "http://google.com";

// 2.
document.getElement("link").attributes.href = "http://google.com";

// 3.
document.getElementById("link").attributes.href = "http://google.com";

// 4.
document.getElement("link").attributes["href"] = "http://google.com";

// 5.
document.getElementById("link").attributes["href"] = "http://google.com";

// 6.
document.getElement("link").href = "http://google.com";

//-------------------------------------------------------------------

// Consider the following code:

<script type="text/javascript">
	function check() {
		var a = "Text 1";
	}

	var a = "Text 2";

	check();

	var result = a;

</script>

// What will be the value of "result" ?

// 1. null
// 2. Text 2
// 3. Text 1
// 4. Nothing, the script is not correct

// Answer: result => "Text 2"

//-------------------------------------------------------------------

// Consider the following code:

<script type="text/javascript">

	function A(param) {
		var m = param;
		m = m + 10;
		return m;
	}
	function B(param) {
		var n = param;
		n = 20;
	}

	var result = A(10)*B(10);

</script>

// What will be the value of "result" ?

// 1.	0
// 2.	200
// 3.	400
// 4.	20
// 5.	NaN

// Answer => NaN
// A(10) => 20
// B(10) => undefined

// Notes: The isNaN() function determines whether a value is an illegal number (Not-a-Number).

//-------------------------------------------------------------------

// Consider the following code:

<script type="text/javascript">

	function a() { return "1st"; };

	function a(val) { this.a1 = "right"; return "2nd"; };

	var result = new a().a1;

</script>

// What will be the value of "result" ?

// 1.	right
// 2.	2nd
// 3.	undefined
// 4.	1st
// 5.	null
// 6. 	Nothing, the script is not correct.

// Answer. result => right
// Discussion: a() => "2nd"


//-------------------------------------------------------------------

// Consider the following code:

<script type="text/javascript">

	var num = 1;
	var result = num++ * 10 + 1;

</script>

// What will be the value of "result" ?

// 1.	21
// 2.	11
// 3.	3
// 4.	22

// Answer: result => 11

//-------------------------------------------------------------------

// Consider the following code:

<script type="text/javascript">

	var s = 'Hello world';

	s[0] = 'W';

</script>

// What will be the value of "s" ?

// 1.	'Hello world'
// 2.	'W'
// 3.	'Wello world'
// 4.	Nothing, the script is not correct

// Answer: s => "Hello world"
// Discussion: s[0] = 'H'

//-------------------------------------------------------------------

