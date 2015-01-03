<?php
    /**
     * login1.php
     *
     * A simple login module.
     *
     * David J. Malan
     * malan@harvard.edu
     */

    // enable sessions
    session_start();

    // were this not a demo, these would be in some database
    define("USER", "cf");
    define("PASS", "123456");

    // if username and password were submitted, check them
    if (isset($_POST["user"]) && isset($_POST["pass"]))
    {
        // if username and password are valid, log user in
        if ($_POST["user"] == USER && $_POST["pass"] == PASS)
        {
            // remember that user's logged in
            $_SESSION["authenticated"] = true;

            // redirect user to home page, using absolute path, per
            // http://us2.php.net/manual/en/function.header.php
            $host = $_SERVER["HTTP_HOST"];
            $path = rtrim(dirname($_SERVER["PHP_SELF"]), "/\\");
            header("Location: http://$host$path/home.php");
            exit;
        }
    }
?>

<!DOCTYPE html>

<html>
  <head>
    <title>Log In</title>
  </head>
  <body>
    <?php if (count($_POST) > 0) echo "INVALID LOGIN"; ?>
    <form action="<?php print $_SERVER["PHP_SELF"] ?>" method="post">
      <table>
        <tr>
          <td>Username:</td>
          <td><input name="user" type="text"></td>
        </tr>
        <tr>
          <td>Password:</td>
          <td><input name="pass" type="password"></td>
        </tr>
        <tr>
          <td></td>
          <td><input type="submit" value="Log In"></td>
        </tr>
      </table>      
    </form>
  </body>
</html>
