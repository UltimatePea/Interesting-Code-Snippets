var assert = require('assert');
function fact (n)  {
	if( n == 0) {
		return 1;
	} else {
		return fact(n-1) * n;
	}
}

function factCPS(n){
	return cpsfact(n, function(val){ return val});
}

function cpsfact(n, cont){
	if (n == 0){
		return cont(1);
	} else {
		return cpsfact(n-1, function(val){ return cont(val * n)});
	}
}


assert(fact(10) == factCPS(10));
