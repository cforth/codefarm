<?php
class Foo
{
    public function __call($method, $args)
    {
        if (isset($this->$method)) {
            $func = $this->$method;
            $func($args);
        }
    }
}

$foo = new Foo();
$foo->bar = function () { echo "Hello, this function is added at runtime"; };
$foo->bar();
?>
