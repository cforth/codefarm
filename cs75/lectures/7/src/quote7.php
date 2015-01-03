<?
    /**
     * quote7.php
     *
     * Outputs price, low, and high of given symbol in JSON format
     * using PHP's JSON extension.
     *
     * David J. Malan
     * Computer Science S-75
     * Harvard Summer School
     */

    // defines a stock
    class Stock
    {
        public $price;
        public $high;
        public $low;
    }

    // set MIME type
    header("Content-type: application/json");

    // try to get quote
    $handle = @fopen("http://download.finance.yahoo.com/d/quotes.csv?s={$_GET['symbol']}&f=e1l1hg", "r");
    if ($handle !== FALSE)
    {
        $data = fgetcsv($handle);
        if ($data !== FALSE && $data[0] == "N/A")
        {
            $stock = new Stock();
        
            if (is_numeric($data[1]))
                $stock->price = $data[1];
            if (is_numeric($data[2]))
                $stock->high = $data[2];
            if (is_numeric($data[3]))
                $stock->low = $data[3];
        }
        fclose($handle);
    }

    // output JSON
    print(json_encode($stock));
?>
