<?php
  /*home.php*/

  session_start();
?>

<!DOCTYPE html>

<html>
  <head>
    <title>Home</title>
  </head>
  <body>
    <h1>Home</h1>
    <h3>
      <?php if (isset($_SESSION["authenticated"]) && $_SESSION["authenticated"] === true) { 
        print "You are logged in!";
       } else { 
        print "You are not logged in!";
       } 
       ?>
    </h3>
    <br/>
    <b>Login Demo</b>
    <ul>
      <li><a href="login1.php">version 1</a></li>
      <li><a href="login2.php">version 2</a></li>
      <li><a href="login3.php">version 3</a></li>
      <li><a href="login4.php">version 4</a></li>
    </ul>
  </body>
</html>
