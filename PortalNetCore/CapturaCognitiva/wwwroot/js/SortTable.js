var arr = document.querySelectorAll('[sortable="sortable"]');
if (arr) {
    for (i = 0; i < arr.length; i++) {
        var node = document.createElement("i");
        node.classList += "fa fa-sort";
        arr[i].appendChild(node);
        arr[i].addEventListener("click", function (event) {
            var element = event.target || event.srcElement;
            var th = getNearestTableAncestor(element, 'th');
            if (th)
                element = th;

            var table = getNearestTableAncestor(element, 'table');

            var asc = element.getAttribute("asc");
            if (asc) asc = false;
            else asc = true;

            sortTable(table, element.cellIndex, !asc);
            element.setAttribute("asc", !asc);
        });
    }
}
function sortTable(table, index, asc) {
    var rows, switching, i, x, y, shouldSwitch;
    switching = true;
    while (switching) {
        switching = false;
        rows = table.rows;
        for (i = 1; i < (rows.length - 1); i++) {
            shouldSwitch = false;
            x = rows[i].children[index];
            y = rows[i + 1].children[index];
            if (asc) {
                if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                    shouldSwitch = true;
                    break;
                }
            } else {
                if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                    shouldSwitch = true;
                    break;
                }
            }
        }
        if (shouldSwitch) {
            rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
            switching = true;
        }
    }
}
function getNearestTableAncestor(htmlElementNode, type) {
    while (htmlElementNode) {
        htmlElementNode = htmlElementNode.parentNode;
        if (htmlElementNode.tagName.toLowerCase() === type) {
            return htmlElementNode;
        }
    }
    return undefined;
}
function comparer(index) {
    return function (a, b) {
        var valA = getCellValue(a, index), valB = getCellValue(b, index);
        return $.isNumeric(valA) && $.isNumeric(valB) ? valA - valB : valA.toString().localeCompare(valB);
    };
}
function getCellValue(row, index) { return $(row).children('td').eq(index).text(); }
function searchInTable(table, filter) {
    filter = filter.trim().replace(/ /g, "").toUpperCase();
    var tr = table.getElementsByTagName("tr");
    for (var i = 1; i < tr.length; i++) {
        if (rowContains(tr[i].getElementsByTagName("td"), filter)) {
            tr[i].style.display = "";
        } else {
            tr[i].style.display = "none";
        }
    }
}
function rowContains(td, filter) {
    if (td) {
        for (var j = 0; j < td.length; j++) {
            var txtValue = (td[j].textContent || td[j].innerText || td[j].innerHtml).trim().replace(/ /g, "").toUpperCase();
            if (filter === "" || txtValue.indexOf(filter) > -1) {
                return true;
            }
        }
    }
    return false;
}