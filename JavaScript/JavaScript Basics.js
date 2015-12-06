/*
JavaScript's fundamental datatype is the object.
An object is an unordered collection of properties, each of which has a name and a value

The 'null' and 'undefined'values have no properties
*/

var x = true && true && true && 5 // => 5, instead of writing if statements


this.x = 1 // creates a configurable global property (no var)
delete this.x

!== and === // distingwish between 'undefined' and 'null'

var o = {x:1};
o.hasOwnProperty("x");
o.propertyIsEnumerable("x");

/*
Print numbers in reverse order
*/

function reverse(str) {
	return str.split("").reverse().join("");
}

console.log(reverse('hello world'));


/*
When you declare a global JavaScript variable you define a preperty of the global object.
If you use 'var' to declare the variable, the property that is created is non-configurable, which means that it cannot be deleted with the 'delete' operator
*/

/*
Discussion on: Function Scope and Hoisting

Answer:
This answer intentionally left blank

*/

"1" == true // => true
3 << 2 // => 12 ( 3*(2^2) = 3*4 )
5 << 4 // => 80 ( 5* (2^4) = 5*16 )
10 >> 2 // => 2 ( 10/ (2^2) = 10/4 )
-10 >> 2 // => -3 ( -10/ (2^2) = -10/4= -2.5)
"11" < "3" //=> true (String comparison); refer to ASCII Table
"11" < 3 //=> false (Numeric comparison)
"one" < 3 //=> false (Numeric comparison NaN)

// index=> [0][1][2]
var data = [7, 8, 9];
"0" in data // => true, array has an element [0]
1 in data // => true, number is converted to String
3 in data // false, no element [3]


if(a==b) stop(); // invoke stop() only if a==b
(a==b) && stop(); // this does the same thing


!(p && q) === !p || !q
!(p || q) === !p && !q


username = "";
if (!username) username = "Joh"; // if username is null, undefined, false, 0, "", or NaN, give it a new value




// if x is 'undefined, null, "", 0, or NaN', leave it alone:
if (o.x) o.x *= 2;
// not like this:
if (o.x != null) o.x = 2;


o = { bar: 42 };
d = Object.getOwnPropertyDescriptor(o, 'bar');
// d is { configurable: true, enumerable: true, value: 42, writable: true }

/* Sparse Arrays */

a = new Array();  // a.length is 0
a = new Array(5); // a.length is 5
a[1000] = 0; 	  // a.length is 1001

var a2 = Array(3); // this array has no values at all
a2[0]; // => undefined
0 in a2 // => false, has no element
a2[0] = 3; 
0 in a2 // => true, has element


var keys = Array(5);
// Loop optimized:
for (var i=0, len = keys.length; i < len; i++) { 
	// loop
	console.log('loop ' + i);
}

if (!a[i]) continue; // skip null, undefined ...

var data = [1, 2, 3, 4, 5];
var sum = 0;
data.forEach ( function(x) {sum += x; });

sum // => 15


/*
If an array contains 'undefined' elements, they are sorted to the end of the array
*/
var a = [5, 2, 4, 3, 1];
a.sort ( function(a, b) {
	return a - b;
});
// => numerical order: 

slice() // does not modify the array on which it is invoked

splice() // returns an array of the deleted elements

push() // method appends one or more new elements to the end of an array and returns the new length of the array

pop() // method does the reverse: it deletes the last element of an array, decrements the array length, and returns the value that it removed.

unshift() // adds an element or elements to the beginning of the array

shift() // removes and returns the first element of the array

var data = [1, 2, 3, 4, 5];

data.forEach( function (v, i, a) { a[i] = v + 1; });
data 
// => [2, 3, 4, 5, 6]

map() // returns a new array: it does not modify the array it is invoked on
a = [1, 2, 3];
b = a.map( function(x) { return x*x;});
// => [1, 4, 9]

a = [5, 4, 3, 2, 1];
a.filter( function(x){ return x<3 } );
// => [2, 1]

// return odd numbers
a.filter( function(x, i){ return i%2==0});
// => [5, 3, 1]

a = a.filter(function(x){ return x !== null && x !== undefined});
// => [5, 4, 3, 2, 1]

a.every( function(x) { return x<10;});
// => true- all values < 10

a.every( function(x) { return x%2===0;});
// => false -  not all values even

a.some( function(x){ return x%2===0;});
// => true -  'a' has some even numbers

a.some(isNaN);
// => false - 'a' has no non numbers

reduce() // method produce a single value

var a = [1, 2, 3, 4, 5];
var sum = a.reduce( function(x, y){ return x+y}, 5);
sum
// => 20: sum f values 15 + 5 = 20

var sum = a.reduce( function(x, y){ return x*y}, 2);
sum
// => 240:  120*2=240

//largest value
var max = a.reduce( function(x,y){ return (x>y)?x:y;});

indexOf() // returns the index within the calling String object of the first occurrence of the specified value
'abcdefg'.indexOf('c');
//=> 2
 
lastIndexOf() // returns the last index at which a given element can be found in the array, or -1 if it is not present. 
var array = [2, 5, 9, 2];
array.lastIndexOf(2);     // => 3

'abcdefgc'.lastIndexOf('c');
// => 7