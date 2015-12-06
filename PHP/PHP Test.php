<?php

echo 'This is a test'; // This is a one-line c++ style comment
/* This is a multi line comment
   yet another line of comment */
echo 'This is yet another test';
echo 'One Final Test'; # This is a one-line shell-style comment

//----------------------------------------------

#What will the following PHP script display?

$str = 123;

echo "Value of variable - \$str";

#Answer:
Value of variable - $str

//----------------------------------------------

# What is the "<<<" operator used for?

# 1. To declare a regular expression.
# 2. It is similar to "echo".
# 3. To declare a string variable.

#Answer:
# http://php.net/manual/en/language.operators.bitwise.php

//----------------------------------------------

# Which function returns a list of response headers?

# 1. headers()
# 2. headers_list()
# 3. headers_send()
# 4. header_getAll()

# Answer:
# 2. headers_list()
# http://php.net/manual/en/function.headers-list.php
# headers_list — Returns a list of response headers sent (or ready to send)

//----------------------------------------------

# What will the following PHP script display?

$number = array(0.57, '21.5', 40.52);

if (in_array(21.5, $number, true)) echo "The value 21.5 is found";
else echo "21.5 is not found";

# Options:
# 1. "The value 21.5 is found"
# 2. "21.5 is not found"
# 3. Nothing. The script is invalid.

#Answer:
# 21.5 is not found

//----------------------------------------------

# How could the expression in "echo" below be fixed?

$arr['one']=14;
echo "Event happened $arr['one'] days ago";

# Options

# 1. $arr{one}
# 2. " . $arr['one'] . "
# 3. {$arr['one']}

# Answer:
# 3. {$arr['one']}
# echo "Event happened {$arr['one']} days ago";

//----------------------------------------------

# What is the difference between accessing class methods via "->" and accessing them via "::"?

# Options:

# 1. "->" is for non-static methods, "::" is for static methods.
# 2. "->" is for static methods, "::" is for non-static methods.
# 3. "->" is for all methods, "::" is for static methods.
# 4. "->" is for static methods, "::" is for all methods.
# 5. There is no difference

# Answer:
# 3. "->" is for all methods, "::" is for static methods.
# http://php.net/manual/en/language.oop5.paamayim-nekudotayim.php

# The Scope Resolution Operator (also called Paamayim Nekudotayim) or in simpler terms, the double colon,
#  is a token that allows access to static, constant, and overridden properties or methods of a class.

//----------------------------------------------

# How do you start a PHP session?

#Options

# 1. Using session_start()
# 2. Using session_set()
# 3. Using the variable $_SESSION
# 4. Using session_register()

# Answer:
# 1. Using session_start()
# A session is started with the session_start() function.
# http://www.w3schools.com/php/php_sessions.asp


//----------------------------------------------

# What will the following PHP script display?

function get_sum()
{
	global $var;
	$var = 5;
}

$var = 10;

get_sum();
echo $var;

#Options

# 1. 10
# 2. 15
# 3. NULL
# 4. 5

# Answer:
# => 5

//----------------------------------------------

# What is "heredoc" used for?

# 1. Creating single-line strings with quotation marks
# 2. Creating single-line strings without quotation marks
# 3. Creating multi-line strings without quotation marks
# 4. Creating multi-line strings with quotation marks

# Answer:
# 3. Creating multi-line strings without quotation marks
# http://php.net/manual/en/language.types.string.php#language.types.string.syntax.heredoc
# Heredoc text behaves just like a double-quoted string, without the double quotes. 

/* You can use anything you like; "EOT" is just an example */
echo $str = <<<EOD 
Example of string
spanning multiple lines
using heredoc syntax.
EOD;

//----------------------------------------------

# Which function is best suited for removing markup tags from a string?

#Options

# 1.
strip_markup()
# 2.
strip_tags()
# 3.
str_replace()
# 4.
preg_replace()

# Answer:
# 2. strip_tags()
# http://php.net/manual/en/function.strip-tags.php

//----------------------------------------------

# Which change will make the following PHP script display the string "Hello, World!"?

function myFunction()
{
	//?????????
	print $string;
}
myFunction("Hello, World!");

# 1. Replacing ????? with
$string = $argv[1];
# 2. Replacing ????? with
list($string) = func_get_args();
# 3. Replacing ????? with
$string = get_function_args();
# 4. None of these changes will make the cript function as described.

# Asnwer:
# 2. Replacing ????? with list($string) = func_get_args();
function myFunction()
{
	list($string) = func_get_args();
	print $string;
}
myFunction("Hello, World!");

//----------------------------------------------

?>