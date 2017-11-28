var assert = require('assert');
// I gained insights from https://github.com/chenyukang/eopl/blob/master/ch2/12.scm
function emptyStack() {
	return function(cmd){
		if(cmd == 'check empty'){
			return true;
		} else {
			throw Error("Operations on an empty Stack");
		}
	}
}

function push(elem, stack){
	return function(cmd){
		if(cmd == 'top'){
			return elem;
		} else if (cmd == 'pop'){
			return stack;
		} else if (cmd == 'check empty'){
			return false;
		} else {
			throw Error("Illegal op : " + cmd);
		}
	}
}

function pop( stack){
	return stack('pop');
}

function top(stack){
	return stack('top');
}

function isEmpty(stack){
	return stack('check empty');
}

// test codes
//
var s1 = emptyStack();
assert(isEmpty(s1));
s1 = push(2,s1);
assert(top(s1)==2);
s1 = push(3,s1);
assert(top(s1)==3);
assert(!isEmpty(s1));
s1 = pop(s1);
assert(top(s1)==2);
s1 = pop(s1);
assert(isEmpty(s1));

