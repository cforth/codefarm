
    //利用json格式的股票行情数据绘制表格
    function makeJsonTable(data) {
      var theadStr = new Array ("序号", "股票代码", "股票名称", "当前价格", "当日涨跌", "最高价", "最低价", "今日开盘价", "昨日收盘价");
      
      var sTable = document.createElement("table");
      
      var sThead = document.createElement("thead");
      sTable.appendChild(sThead);

      var sTbody = document.createElement("tbody");
      sTable.appendChild(sTbody);
      
      var sTfoot = document.createElement("tfoot");
      sTable.appendChild(sTfoot);
      
      sThead.insertRow(0);
      for(var j=0; j<9; j++) {
        sThead.rows[0].insertCell(j);
        sThead.rows[0].cells[j].appendChild(document.createTextNode(theadStr[j]));
      }

      var n = 0;
      for(var i in data) {
        sTbody.insertRow(n);
        for(j=0; j<9; j++) {
          sTbody.rows[n].insertCell(j);
        }
        sTbody.rows[n].cells[0].appendChild(document.createTextNode(n));
        sTbody.rows[n].cells[1].appendChild(document.createTextNode(data[i]["symbol"]));
        sTbody.rows[n].cells[2].appendChild(document.createTextNode(data[i]["name"]));
        sTbody.rows[n].cells[3].appendChild(document.createTextNode(data[i]["price"]));
        sTbody.rows[n].cells[4].appendChild(document.createTextNode((data[i]["percent"] * 100).toFixed(2) + "%"));
        sTbody.rows[n].cells[5].appendChild(document.createTextNode(data[i]["high"]));
        sTbody.rows[n].cells[6].appendChild(document.createTextNode(data[i]["low"]));
        sTbody.rows[n].cells[7].appendChild(document.createTextNode(data[i]["open"]));
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
       
         
        script.onload = script.onreadystatechange = function(){ 
          if (!this.readyState || 
          this.readyState === "loaded" || 
          this.readyState === "complete" ) {
          this.onload = this.onreadystatechange = null;
          this.parentNode.removeChild(this);
          }
        }

    }
