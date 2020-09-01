function addParameterUrl(url, name, value) {
    if (value !== null && value !== undefined && url !== null && url !== undefined && url !== "") {       
        var index = 0;
        index = url.indexOf(`?${name}=`);
        if (index === -1)
            index = url.indexOf(`&${name}=`);
        if (index !== -1)
            url = url.substring(0, index);
        var separator = "?";
        if (url.includes("?"))
            separator = "&";
        if (value !== "")
            url = `${url}${separator}${name}=${value}`;
    }
    return url;
}
function setError(control, msg) {
    control.style.color = "#ff0000";
    control.style.borderColor = "#ff0000";
    control.setAttribute("title", msg);
    control.focus();
    return false;
}
function setErrorMsg(control, msg, label) {
    control.style.color = "#ff0000";
    control.style.borderColor = "#ff0000";
    control.setAttribute("title", msg);
    control.focus();
    label.innerHTML = msg;
    return false;
}
var inputs = document.getElementsByTagName('input');
for (var i = 0; i < inputs.length; i++) {
    if (inputs[i].type.toLowerCase() === 'number') {
        var current = inputs[i].getAttribute("value");
        if (current) {
            inputs[i].value = parseFloat(current);
        }
        inputs[i].addEventListener("keyPress", OnlyNumbers);
    }
}
function OnlyNumbers(e) {
    tecla = (document.all) ? e.keyCode : e.which;
    if (tecla === 8) {
        return true;
    }
    if (e.target.value) {
        if (e.target.min && parseFloat(e.target.value) < parseFloat(e.target.min)) {
            e.target.value = e.target.min;
        }
        if (e.target.max && parseFloat(e.target.value) > parseFloat(e.target.max)) {
            e.target.value = e.target.max;
        }
    }
    patron = /[0-9]/;
    tecla_final = String.fromCharCode(tecla);
    return patron.test(tecla_final);
}
String.prototype.addParameterUrl =
    function (name, value) {
        if (value !== null && value !== undefined && value !== "") {
            var separator = "?";
            if (url.includes("?"))
                separator = "&";
            url = `${url}${separator}${name}=${value}`;
        }
        return url;
    };
String.prototype.format =
    function () {
        var formatted = this;
        for (var i = 0; i < arguments.length; i++) {
            var regexp = new RegExp('\\{' + i + '\\}', 'gi');
            formatted = formatted.replace(regexp, arguments[i]);
        }
        return formatted;
    };
function searchOnUserList(inputName, listName) {
    var filter, ul, li, i, txtValue;
    filter = document.getElementById(inputName).value.toUpperCase();
    ul = document.getElementById(listName);
    li = ul.getElementsByTagName("option");
    for (i = 0; i < li.length; i++) {
        txtValue = li[i].textContent || li[i].innerText;
        if (txtValue.toUpperCase().indexOf(filter) > -1) {
            li[i].style.display = "";
        } else {
            li[i].style.display = "none";
        }
    }
}