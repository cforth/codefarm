<?
    /**
     * quote5.php
     *
     * Outputs price, low, and high of given symbol as text/xml.
     *
     * David J. Malan
     * Computer Science S-75
     * Harvard Summer School
     */

    // set MIME type
    header("Content-type: text/xml");

    // output root element's start tag
    print("<quote symbol='{$_GET['symbol']}'>");

    // try to get quote
    $handle = @fopen("http://download.finance.yahoo.com/d/quotes.csv?s={$_GET['symbol']}&f=e1l1hg", "r");
    if ($handle !== FALSE)
    {
        $data = fgetcsv($handle);
        if ($data !== FALSE && $data[0] == "N/A")
        {
            print("<price>{$data[1]}</price>");
            print("<high>{$data[2]}</high>");
            print("<low>{$data[3]}</low>");
        }
        fclose($handle);
    }

    // output root element's end tag
    print("</quote>");
?>
