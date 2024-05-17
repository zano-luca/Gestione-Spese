<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link href="https://cdn.jsdelivr.net/npm/daisyui@4.10.1/dist/full.min.css" rel="stylesheet" type="text/css" />
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        form {
            padding: 20px;
            height: auto;
            width: auto;
            background-color: white;
        }
        .label{
            font-size: 18px;
            color: black;
        }
        .center{
            justify-content: center;
            align-items: center;
            margin-left: 0px;
            display: flex;
        }
        h2{
            color: black;
            text-align: center;
        }
        .white{
            background-color: rgb(255, 255, 255);
            padding: 20px 40px 20px 40px;
            width: auto;
            border: 4px black solid;
            margin: 0 auto;
            border-radius: 13px;
        }
        .text-center {
            text-align: center;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<div class="white">
    <div class="text-center">
        <h2>Operazione andata a buon fine.</h2>
        <h2>Scegli la prossima azione:</h2>
    </div>
    <div class="center">
        <form class="form" action="index.php?action=logout" method="post">
            <div>
                <input class="btn btn-primary" type="submit" value="Logout">
            </div>
        </form>
        <form class="form" action="index.php?action=spesa" method="post">
            <div>
                <input class="btn btn-primary" type="submit" value="Nuova spesa">
            </div>
        </form>
    </div>
</div>
</body>
</html>