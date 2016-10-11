/**
 ** 类似Forth语法的虚拟机函数
 ** myForthEval(':XHHWW') 表示定义一个扩展词'X'，内容为'HHWW'
 ** myForthEval('X') 表示执行这个扩展词'X'
 */
function myForthEval(str){
	i=0;
	if(str[i]==':'){
		i++;
		eval(str[i] + " = function(){myForthEval('" + str.substring(i+1,str.length) + "');}");
	}else{
		while(i<str.length) {
			eval(str[i] + "()");
			i++;
		}
	}
}

/**
 ** 类似Forth中的核心词
 */
function H() {
	console.log("hello");
}

function W() {
	console.log("world");
}
