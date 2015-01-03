<?
    /**
     * quote6.php
     *
     * Outputs price, low, and high of given symbol in JSON format.
     *
     * David J. Malan
     * Computer Science S-75
     * Harvard Summer School
     */

    // set MIME type
    header("Content-type: application/json");

    // try to get quote
    $handle = @fopen("http://download.finance.yahoo.com/d/quotes.csv?s={$_GET['symbol']}&f=e1l1hg", "r");
    if ($handle !== FALSE)
    {
        $data = fgetcsv($handle);
        if ($data !== FALSE && $data[0] == "N/A")
        {
            if (is_numeric($data[1]))
                $price = $data[1];
            if (is_numeric($data[2]))
                $high = $data[2];
            if (is_numeric($data[3]))
                $low = $data[3];
        }
        fclose($handle);
    }

    // output JSON
    print("{ price: $price, high: $high, low: $low }");
?>
