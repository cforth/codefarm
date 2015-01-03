<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Stocks</title>
  </head>
  <body>
    <h1>Stocks</h1>
    <ul>
      <?php 
        $dom = simplexml_load_file("stocks.xml");
        foreach($dom->stock as $stock) {
          print("<li>");
          $path = $stock->url["path"];
          print("<a href='$path'>");
          print($stock["id"]);
          print("</a>");
          print("<ul>");
            print("<li>");
            print($stock->industry["name"]);
            print "</li>";
            print("<li>");
            print($stock->regprice["price"]);
            print "</li>";
            print("<li>");
            print($stock->tarprice["price"]);
            print "</li>";
          print("</ul>");
          print("</li>");
        }

        $results = $dom->xpath("/stocks/stock[@id='002195']");
        if (count($results) == 1) {
          $mystock = $results[0];
          print_r($mystock);
          print ($mystock->tarprice["price"]);
        }
      ?>
    </ul>
  </body>
</html>
