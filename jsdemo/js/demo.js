function validateEmpty(elementName) {
    var objElement = document.getElementById(elementName) ;
    var msgElement = document.getElementById(elementName + "Msg") ;
    if(objElement.value != ""){ //不为空
        objElement.className = "right";
        msgElement.innerHTML = "<font color='green'>输入内容正确！</font>";
        return true;
    } else {
        objElement.className = "wrong";
        msgElement.innerHTML = "<font color='red'>输入内容错误！</font>";
        return false;
    }
}

function validateRepeat(srcName, desName) {
    var srcElement = document.getElementById(srcName);
    var desElement = document.getElementById(desName);
    var msgElement = document.getElementById(desName + "Msg");
    if(srcElement.value == desElement.value) {
        desElement.className = "right";
        msgElement.innerHTML = "<font color='green'>输入内容正确！</font>";
        return true;
    } else {
        desElement.className = "wrong";
        msgElement.innerHTML = "<font color='red'>两次输入内容不一致！</font>";
        return false;
    }
}

function validatePwd() {
    return validateEmpty("pwd");
}

function validateConf() {
    if(validateEmpty("conf")) {
        return validateRepeat("pwd", "conf");
    }
    return validateEmpty("conf");
}
window.onload = function() {
    document.getElementById("pwd").addEventListener("blur", validatePwd, false)
    document.getElementById("conf").addEventListener("blur", validateConf, false)
}
