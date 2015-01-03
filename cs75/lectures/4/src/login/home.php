<?php 
    /**
     * home.php
     *
     * A simple home page for these login demos.
     *
     * David J. Malan
     * Computer Science S-75
     * Harvard Summer School
     */

    // enable sessions
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
      <?php if (isset($_SESSION["authenticated"])) { ?>
        You are logged in!  
        <br />
        <a href="logout.php">log out</a>
      <?php } else { ?>
        You are not logged in!
      <?php } ?>
    </h3>
    <br>
    <b>Login Demos</b>
    <ul>
      <li><a href="login5.php">version 5</a></li>
    </ul>
  </body>
</html>
