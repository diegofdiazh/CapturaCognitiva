if (document.getElementById("state")) {
    var state = new URL(window.location.href).searchParams.get("state");
    if (state) {
        setValueSelect("state", state);
        document.getElementById("state").addEventListener("change", function () { search(); });
    }
}
if (window.location.href.searchParams && window.location.href.searchParams.length > 0) {
    let from = window.location.href.searchParams.get("from");
    if (from && from.value !== undefined) {
        var f = from.value;
        document.getElementById("from").value = f;
    }
    let to = window.location.href.searchParams.get("to");
    if (to && to.value !== undefined) {
        var t = to.value;
        document.getElementById("to").value = t;
    }
    let text = new URL(window.location.href).searchParams.get("search");
    let box = document.getElementById("searcher");
    if (text && box) {
        box.value = text;
    }
}
function search() {
    let url = window.location.href;
    let text = document.getElementById("searcher").value;
    url = addParameterUrl(url, "search", text);
    window.location.href = url;
}
function clear() {
    let url = window.location.href; var separator = "?";
    let index = 0;
    if (url.includes("?search="))
        index = url.indexOf(`?search=`);
    else
        index = url.indexOf(`&search=`);
    if (index !== -1)
        url = url.substring(0, index);
    window.location.href = url;
}
function setValueSelect(id, value) {
    let options = document.querySelectorAll(`[value='${value}']`);
    if (options) {
        for (var i = 0; i < options.length; i++) {
            if (options[i].parentNode.id === id)
                options[i].setAttribute('selected', 'selected');
        }
    }
}
var page = 0;
function Paginate(val) {
    if (val >= 0) {
        let url_string = window.location.href;
        let url = new URL(url_string);
        url_string = url.pathname;
        if (url.searchParams && url.searchParams !== undefined) {
            var text = url.searchParams.get("search");
            if (text) {
                url_string = addParameterUrl(url_string, "search", text);
            }
            var state = url.searchParams.get("state");
            if (state) {
                url_string = addParameterUrl(url_string, "state", state);
            }
            var from = url.searchParams.get("from");
            if (from) {
                url_string = addParameterUrl(url_string, "from", from);
            }
            var to = url.searchParams.get("to");
            if (to) {
                url_string = addParameterUrl(url_string, "to", to);
            }
        }
        url_string = addParameterUrl(url_string, "page", val);
        location.search
            .substr(1)
            .split("&")
            .forEach(function (item) {
                if (!item.startsWith("page=")
                    && !item.startsWith("search=")
                    && !item.startsWith("state=")
                    && !item.startsWith("from=")
                    && !item.startsWith("to=")) {
                    tmp = item.split("=");
                    url_string = addParameterUrl(url_string, tmp[0], tmp[1]);
                }
            });
        window.location.href = url_string;
    }
}
