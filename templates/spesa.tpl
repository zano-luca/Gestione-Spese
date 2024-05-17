<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Spese</title>
    <link href="https://cdn.jsdelivr.net/npm/daisyui@4.10.1/dist/full.min.css" rel="stylesheet" type="text/css" />
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        html{
            margin: 30px;
            margin-bottom: 450px;
            margin-left: 5%; margin-right: 5%;
        }
        body {
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 30px;
        }
        a{
            cursor: pointer;
        }
        .filter{
            margin-left: 20px;
        }
        #form {
            padding: 20px;
            padding-left: 25px;
            height: 430px;
            width: 620px;
            background-color: white;
            border: 4px black solid;
            margin: 0 auto;
            border-radius: 13px;
        }
        .label{
            font-size: 18px;
            color: black;
        }
        .center{
            display: flex;
            justify-content: center;
            align-items: center;
            margin-left: 0px;
            text-align: center;
        }
        .left{
            text-align: left;
            margin-right: 70px;
        }
        .right{
            margin-right: 0px;
            margin-top: -200px;
        }
        h2{
            color: black;
            text-align: center;
            font-size: 15px;
        }
        .white{
            background-color: white;
            padding: 10px;
        }
        .navbar{
            width: 70%;
            border: #4a0658 4px solid;
            margin: 0 auto;
            margin-bottom: 60px;
            text-align: center;
        }
        td, th{
            font-size: 15px;
        }
        table{
            margin-left: 30px;
            margin-right: 130px;
        }
    </style>
</head>
<body>
<div class="navbar">
    <a href="index.php?action=logout">
        <div class="float-right">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
            </svg>
        </div>
    </a>
    <h2 style="margin: 0 auto">Benvenuto <?=$name ?>   </h2>
</div>
<div class="white">
    <form id="form" class="form" action="index.php?action=fine"
          method="post" enctype="multipart/form-data">
        <h2 style="font-size: 23px;">Compila i seguenti campi</h2>
        <br>
        <div class="center">
            <div class="left">
                <div class="center">
                    <label class="label">Importo:</label>
                    <label class="input input-bordered flex items-center gap-2">
                        <input title="Inserisci un numero valido (con o senza virgola)" type="text" pattern="[0-9]+([,\.][0-9]+)?" class="grow" id="importo" name="importo" required/>
                    </label>
                    <label class="label">€</label>
                </div>
                <br>
                <p>Estensioni possibili: .png, .jpeg, .jpg</p>
                <input type="file" name="file" class="file-input file-input-bordered file-input-sm w-full max-w-xs" accept=".png, .jpeg, .jpg" required/>
                <br><br>
                <div class="center"  style="margin-left: -100px;">
                    <label class="label">Data:</label>
                    <label class="input input-bordered flex items-center gap-2">
                        <input type="date" class="grow" id="Data" name="data"/>
                    </label>
                </div>
                <br>
                <div class="center"  style="margin-left: -150px;">
                    <label class="label">Orario:</label>
                    <label class="input input-bordered flex items-center gap-2">
                        <input type="time" class="grow" id="orario" name="orario" />
                    </label>
                </div>
            </div>
            <div class="right" >
                <select name="causa" class="select select-bordered">
                    <option disabled selected>Causale</option>
                    <?php foreach($cause as $causa) : ?>
                    <option><?= $causa['tipologia'] ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
        </div>
        <div class="float-right">
            <input class="btn btn-primary" type="submit" value="Invia dati">
        </div>
    </form>
</div>
<br><br>





<div class="align" style="display: flex; align-items: center;">
    <form class="form" action="index.php?action=filtri" method="post" style="display: inline-block;">
        <label class="filter" style="flex-grow: 0;">Filtra data:</label>
        <select name="filtro" id="filtro" class="select select-bordered" style="flex-grow: 1;">
            <option value="tutte">Tutte</option>
            <option value="anno">Ultimo anno</option>
            <option value="mese">Ultimo Mese</option>
            <option value="settimana">Ultima Settimana</option>
            <option value="oggi">Oggi</option>
        </select>
        <label class="filter" style="flex-grow: 0;">Filtra causa:</label>
        <select name="causa_filtro" class="select select-bordered">
            <option disabled selected>Causa</option>
            <?php foreach($cause as $causa) : ?>
            <option><?= $causa['tipologia'] ?></option>
            <?php endforeach; ?>
        </select>
        <label class="filter" style="flex-grow: 0;">Ordina per: </label>
        <select name="ordine_filtro" class="select select-bordered">
            <option disabled selected>Ordina</option>
            <option value="data_piu_recente">Data più recente</option>
            <option value="data_meno_recente">Data meno recente</option>
            <option value="importo_maggiore">Importo maggiore</option>
            <option value="importo_minore">Importo minore</option>
        </select>
        <input class="btn btn-primary" type="submit" value="Filtra tabella" style="flex-grow: 0; margin-left: 10px;">
    </form>
    <form class="form" action="index.php?action=reset" method="post" style="display: inline-block;">
        <input class="btn btn-primary" type="submit" value="Reset" style="flex-grow: 0; margin-left: 10px;">
    </form>
</div>
<div>
    <label style="margin-top: 50px" class="label">Visualizza le tue spese:</label>
    <table class="table">
        <thead>
        <tr class="bg-base-200">
            <th>N</th>
            <th>Importo (€)</th>
            <th>Causa</th>
            <th>File</th>
            <th>Data</th>
            <th>Ora</th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <?php
                     $contatore = 1;
                     foreach($spese as $spesa) : ?>
        <tr>
            <td><?= $contatore ?></td>
            <td><?= $spesa['importo'] ?></td>
            <td><?= $spesa['tipologia'] ?></td>
            <?php if (!empty($spesa['fotoScontrino'])) : ?>
            <td><a href="<?= $spesa['fotoScontrino'] ?>" download>Scarica</a></td>
            <?php else : ?>
            <td></td>
            <?php endif; ?>
            <td><?= $spesa['data'] ?></td>
            <td><?= $spesa['orario'] ?></td>
            <td><a> Visualizza dettagli</a> </td>
        </tr>
        <?php
                  $contatore++;
                  endforeach;
                  ?>
        </tbody>
    </table>
</div>
</body>
</html>