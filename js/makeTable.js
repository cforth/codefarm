var hqArr = new Array(
          ["300253", "hq_str_sz300253", "软件服务", "2013-10-14", "57.75", "70.00"],
          ["002521", "hq_str_sz002521", "造纸",     "2013-10-14", "8.61",  "9.80" ],
          ["002063", "hq_str_sz002063", "软件服务", "2013-10-14", "19.50", "26.50"]
        )


function stockArrayMake(hqArr) {
  var hqLength = hqArr.length;  
  var result = new Array();

  for(var i=0;i<hqLength;i++) {
    var index = i + 1;
    var ticker = hqArr[i][0];
    var hqStr = eval(hqArr[i][1]).split(",");  
    var industry = hqArr[i][2];
    var myDate = hqArr[i][3];
    var bidPrice = hqArr[i][4];
    var forecastPrice = hqArr[i][5];    

    var name = hqStr[0];
    var nowChange = ((hqStr[3] - hqStr[2]) / hqStr[2]) * 100;
    nowChange = nowChange.toFixed(2); 

    var totalChange = ((hqStr[3] - bidPrice) / bidPrice) * 100;
    totalChange = totalChange.toFixed(2);

    var nowPrice = parseFloat(hqStr[3]);
    nowPrice = nowPrice.toFixed(2);
    
    result[i] = [index, name, ticker, nowChange, nowPrice, industry, myDate, totalChange, forecastPrice];
  }
  return result;
}


//从二维数组array中搜索word，返回含有word的所有行组成的新的二维数组
function arraySearch(array, word) {
  var result = new Array();
  var arrayLength = array.length;
  var arrayWidth = array[0].length;
  var k=0;

  for(var i=0; i<arrayLength; i++) {
    for(var j=0; j<arrayWidth; j++) {
      if (array[i][j] == word) {
        result[k] = new Array();
        for(var m=0; m<arrayWidth; m++) {
          result[k][m] = array[i][m];
        }
        k++;
        break;   //若每行中有多个匹配值则只计入一次。
      }
    }
  }
  return result;
}


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


//根据网页表格的名字、行、列来修改内容
function tableChange(name, line, row, content) {
  var id = name + "L" + line + "R" + row;
  document.getElementById(id).innerHTML= content;
}
