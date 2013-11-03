
    //利用json格式的股票行情数据绘制表格
    function makeJsonTable(data) {
      var sTable = document.createElement("table");

      var sTbody = document.createElement("tbody");
      sTable.appendChild(sTbody);
      
      sTbody.insertRow(0);
      sTbody.rows[0].insertCell(0);
      sTbody.rows[0].cells[0].appendChild(document.createTextNode("序号"));
      sTbody.rows[0].insertCell(1);
      sTbody.rows[0].cells[1].appendChild(document.createTextNode("股票代码"));
      sTbody.rows[0].insertCell(2);
      sTbody.rows[0].cells[2].appendChild(document.createTextNode("股票名称"));
      sTbody.rows[0].insertCell(3);
      sTbody.rows[0].cells[3].appendChild(document.createTextNode("当前价格"));
      sTbody.rows[0].insertCell(4);
      sTbody.rows[0].cells[4].appendChild(document.createTextNode("当日涨跌"));
      sTbody.rows[0].insertCell(5);
      sTbody.rows[0].cells[5].appendChild(document.createTextNode("最高价"));
      sTbody.rows[0].insertCell(6);
      sTbody.rows[0].cells[6].appendChild(document.createTextNode("最低价"));
      sTbody.rows[0].insertCell(7);
      sTbody.rows[0].cells[7].appendChild(document.createTextNode("今日开盘价"));
      sTbody.rows[0].insertCell(8);
      sTbody.rows[0].cells[8].appendChild(document.createTextNode("昨日收盘价"));

      var n = 1;
      for(var i in data) {
        sTbody.insertRow(n);
        sTbody.rows[n].insertCell(0);
        sTbody.rows[n].cells[0].appendChild(document.createTextNode(n));
        sTbody.rows[n].insertCell(1);
        sTbody.rows[n].cells[1].appendChild(document.createTextNode(data[i]["symbol"]));
        sTbody.rows[n].insertCell(2);
        sTbody.rows[n].cells[2].appendChild(document.createTextNode(data[i]["name"]));
        sTbody.rows[n].insertCell(3);
        sTbody.rows[n].cells[3].appendChild(document.createTextNode(data[i]["price"]));
        sTbody.rows[n].insertCell(4);
        sTbody.rows[n].cells[4].appendChild(document.createTextNode((data[i]["percent"] * 100).toFixed(2) + "%"));
        sTbody.rows[n].insertCell(5);
        sTbody.rows[n].cells[5].appendChild(document.createTextNode(data[i]["high"]));
        sTbody.rows[n].insertCell(6);
        sTbody.rows[n].cells[6].appendChild(document.createTextNode(data[i]["low"]));
        sTbody.rows[n].insertCell(7);
        sTbody.rows[n].cells[7].appendChild(document.createTextNode(data[i]["open"]));
        sTbody.rows[n].insertCell(8);
        sTbody.rows[n].cells[8].appendChild(document.createTextNode(data[i]["yestclose"]));
        n += 1;
      }

      document.body.appendChild(sTable);
    }


    function doJsonp(url, callback) {
        // 创建script标签，设置其属性
        var script = document.createElement('script');
        script.setAttribute('src', url);
        // 把script标签加入head，此时调用开始
        document.getElementsByTagName('head')[0].appendChild(script); 

    }
