function validateEmpty(eleName) {
    var obj = document.getElementById(eleName); //取得对象
    var msg = document.getElementById(eleName + "Msg"); //提示信息
    if(obj.value != "") { //进行内容验证
        obj.className = "right";
        msg.innerHTML = "<font color='green'>内容输入正确！</font>";
        return true ;
    } else {
        obj.className = "wrong";
        msg.innerHTML = "<font color='red'>内容为空！</font>";
        return false ;
    }
}

function validateRegex(eleName, regex) {
    var obj = document.getElementById(eleName); //取得对象
    var msg = document.getElementById(eleName + "Msg"); //提示信息
    if(regex.test(obj.value)) { //进行内容验证
        obj.className = "right";
        msg.innerHTML = "<font color='green'>内容输入正确！</font>";
        return true ;
    } else {
        obj.className = "wrong";
        msg.innerHTML = "<font color='red'>内容输入错误！</font>";
        return false ;
    }
}

function changeColor(obj, color) {
    obj.bgColor = color;
}