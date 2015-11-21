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

