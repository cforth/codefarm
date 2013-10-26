var hqArr = new Array(
          ["300253", "hq_str_sz300253", "软件服务", "2013-10-14", "57.75", "70.00"],
          ["002521", "hq_str_sz002521", "造纸",     "2013-10-14", "8.61",  "9.80" ],
          ["002063", "hq_str_sz002063", "软件服务", "2013-10-14", "19.50", "26.50"]
        )


function makeTable(array) {
  document.write("<table>");
  tableLength = array.length;
  tableWidth = array[0].length;  

  for(var i=0;i<tableLength;i++) {
    document.write("<tr>");
    for(var j=0;j<tableWidth;j++) {
      document.write("<td id=\"tableLine"+ i +"Row" + j +"\">"+ array[i][j] +"</td>");
    }
    document.write("</tr>");
  }

  document.write("</table>");
}


function changeTable(array, id, content) {
  document.getElementById(id).innerHTML= content;
}
