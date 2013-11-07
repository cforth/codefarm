var hqArr = new Array(
          ["1","300253", "测试1", "-1.22","58.00","软件服务", "2013-10-14", "57.75", "70.00", "23"],
          ["2","002521", "测试2", "2.23","8.5","造纸",     "2013-10-14", "8.61",  "9.80", "2" ],
          ["3","002063", "测试3", "9.66","20.20","软件服务", "2013-10-14", "19.50", "26.50","4"]
        )

//根据二维数组array来建立网页表格，并给每个单元格设置id，如第3行第2列，则此单元格id为name+“L3R2”
function tableMake(array, name) {
  document.write("<table class=\"sortable\" id=\"stocktable\">\
      <tr id=\"sthead\">\
        <td>序号<\/td>\
        <td>股票代码<\/td>\
        <td>股票名称<\/td>\
        <td>当日涨跌<\/td>\
        <td>当前价格<\/td>\
        <td>行业分类<\/td>\
        <td>关注日期<\/td>\
        <td>累计涨跌<\/td>\
        <td>目标价格<\/td>\
        <td>溢价空间<\/td>\
      <\/tr>");

  tableLength = array.length;
  tableWidth = array[0].length;  

  for(var i=1;i<=tableLength;i++) {
    document.write("<tr>");
    for(var j=1;j<=tableWidth;j++) {
      document.write("<td id=\"" + name + "L" + i +"R" + j +"\">"+ array[i-1][j-1] +"</td>");
    }
    document.write("</tr>");
  }

  document.write("</table>");
}
