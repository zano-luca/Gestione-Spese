<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrazione</title>
    <link href="https://cdn.jsdelivr.net/npm/daisyui@4.10.1/dist/full.min.css" rel="stylesheet" type="text/css" />
    <script src="https://cdn.tailwindcss.com"></script>

    <style>
        html {
            scroll-behavior: smooth;
        }
        body {
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            position: relative;
            scroll-behavior: smooth;
        }
        td, th{
            font-size: 15px;
        }
        #form {
            padding: 20px;
            height: 670px;
            width: 400px;
            margin: auto;
            border: black 4px solid;
            border-radius: 10px;
            background-color: white;
        }
        .label{
            font-size: 18px;
            color: black;
        }
        .error-message {
            background-color: #F87171;
            color: white;
            padding: 10px;
            border-radius: 5px;
            margin-top: 10px;
            max-width: 400px; /* Imposta la larghezza massima desiderata */
            width: auto; /* Imposta la larghezza automaticamente in base al contenuto */
            margin-left: auto; /* Centra il messaggio orizzontalmente */
            margin-right: auto;
        }
        .error-message2 {
            display: none;
            background-color: #F87171;
            color: white;
            padding: 10px;
            border-radius: 5px;
            margin-top: 10px;
            max-width: 400px; /* Imposta la larghezza massima desiderata */
            width: auto; /* Imposta la larghezza automaticamente in base al contenuto */
            margin-left: auto; /* Centra il messaggio orizzontalmente */
            margin-right: auto;
        }
        .successful-message {
            background-color: #3fcb07;
            color: white;
            padding: 10px;
            border-radius: 5px;
            margin-top: 10px;
            max-width: 400px; /* Imposta la larghezza massima desiderata */
            width: auto; /* Imposta la larghezza automaticamente in base al contenuto */
            margin-left: auto; /* Centra il messaggio orizzontalmente */
            margin-right: auto;
        }
        .navbar{
            width: 70%;
            border: #4a0658 4px solid;
            margin: 0 auto;
            margin-bottom: 60px;
            text-align: center;
        }
        .delete-button {
            background: none;
            border: none;
            cursor: pointer;
            padding: 0;
            width: 24px;
            height: 24px;
        }
        .delete-button svg {
            fill: #000;
            width: 100%;
            height: 100%;
        }
        .delete-button:hover svg {
            fill: red;
        }
    </style>
</head>
<body class="text-xl">
<div class="navbar">
    <a href="index.php?action=logout">
        <div class="float-right">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
            </svg>
        </div>
    </a>
    <h2 style="margin: 0 auto">Benvenuto admin</h2>
</div>
<div class="flex justify-center items-center space-x-3 pb-8 ">
    <a href="#utenti"> <btn class=" btn btn-primary text-xl ">utenti</btn> </a>
    <a href="#tabella-spese"> <btn class="btn btn-primary text-xl">spese</btn> </a>
</div>

<form class="form" id="form" action="index.php" method="post" onsubmit="return validateForm()">

    <label class="label">Crea un Account</label>

    <label class="input input-bordered flex items-center gap-2">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" class="w-4 h-4 opacity-70"><path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6ZM12.735 14c.618 0 1.093-.561.872-1.139a6.002 6.002 0 0 0-11.215 0c-.22.578.254 1.139.872 1.139h9.47Z" /></svg>
        <input type="text" class="grow" id="username" placeholder="username" name="NewUsername" required/>
    </label>

    <br>

    <label class="input input-bordered flex items-center gap-2">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" class="w-4 h-4 opacity-70"><path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6ZM12.735 14c.618 0 1.093-.561.872-1.139a6.002 6.002 0 0 0-11.215 0c-.22.578.254 1.139.872 1.139h9.47Z" /></svg>
        <input type="email" class="grow" id="email" placeholder="E-mail" name="email" required/>
    </label>

    <br>

    <label class="input input-bordered flex items-center gap-2">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" class="w-4 h-4 opacity-70"><path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6ZM12.735 14c.618 0 1.093-.561.872-1.139a6.002 6.002 0 0 0-11.215 0c-.22.578.254 1.139.872 1.139h9.47Z" /></svg>
        <input type="text" class="grow" id="nome" placeholder="nome" name="nome" required/>
    </label>
    <br>

    <label class="input input-bordered flex items-center gap-2">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" class="w-4 h-4 opacity-70"><path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6ZM12.735 14c.618 0 1.093-.561.872-1.139a6.002 6.002 0 0 0-11.215 0c-.22.578.254 1.139.872 1.139h9.47Z" /></svg>
        <input type="text" class="grow" id="cognome" placeholder="cognome" name="cognome" required/>
    </label>

    <br>

    <label class="input input-bordered flex items-center gap-2">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" class="w-4 h-4 opacity-70"><path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6ZM12.735 14c.618 0 1.093-.561.872-1.139a6.002 6.002 0 0 0-11.215 0c-.22.578.254 1.139.872 1.139h9.47Z" /></svg>
        <input type="number" min="0" class="grow" id="matricola" placeholder="id matricola" name="matricola" required/>
    </label>

    <br>

    <label class="input input-bordered flex items-center gap-2">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" class="w-4 h-4 opacity-70"><path fill-rule="evenodd" d="M14 6a4 4 0 0 1-4.899 3.899l-1.955 1.955a.5.5 0 0 1-.353.146H5v1.5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1-.5-.5v-2.293a.5.5 0 0 1 .146-.353l3.955-3.955A4 4 0 1 1 14 6Zm-4-2a.75.75 0 0 0 0 1.5.5.5 0 0 1 .5.5.75.75 0 0 0 1.5 0 2 2 0 0 0-2-2Z" clip-rule="evenodd" /></svg>
        <input type="password" class="grow" id="password" placeholder="password" name="NewPassword" required/>
    </label>

    <br>

    <label class="input input-bordered flex items-center gap-2">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" class="w-4 h-4 opacity-70"><path fill-rule="evenodd" d="M14 6a4 4 0 0 1-4.899 3.899l-1.955 1.955a.5.5 0 0 1-.353.146H5v1.5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1-.5-.5v-2.293a.5.5 0 0 1 .146-.353l3.955-3.955A4 4 0 1 1 14 6Zm-4-2a.75.75 0 0 0 0 1.5.5.5 0 0 1 .5.5.75.75 0 0 0 1.5 0 2 2 0 0 0-2-2Z" clip-rule="evenodd" /></svg>
        <input type="password" class="grow" id="confirm_password" placeholder="conferma Password" name="confirm_password" required/>
    </label>

    <br>

    <div class="float-right">
        <input class="btn btn-primary" type="submit" value="Crea Account">
    </div>

</form>

<?php if (isset($successful) && $successful): ?>
<div class="successful-message" style="display:block" id="successful">Utente creato</div>
<?php elseif (isset($successful) && !$successful): ?>
<div class="error-message" style="display:block" id="error">Username, email o matricola già esistenti</div>
<?php endif; ?>
<div class="error-message2" id="password-error">Le password non coincidono</div>

<br>
<br><br>
<div>
    <label id="utenti" style="margin-top: 50px" class="label">Visualizza gli utenti:</label>
    <table class="table">
        <thead>
        <tr class="bg-base-200">
            <th>Matricola</th>
            <th>Username</th>
            <th>Email</th>
            <th>Nome</th>
            <th>Cognome</th>
        </tr>
        </thead>
        <tbody>
        <?php foreach ($users as $user): ?>
        <tr>
            <td><?php echo $user['matricola']; ?></td>
            <td><?php echo $user['username']; ?></td>
            <td><?php echo $user['email']; ?></td>
            <td><?php echo $user['nome']; ?></td>
            <td><?php echo $user['cognome']; ?></td>
        </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
</div>
<br>
<br>
<br>

<div class="align" style="display: flex; align-items: center;">
    <form class="form" action="index.php?action=filtri" method="post" style="display: inline-block;">
        <label class="filter" style="flex-grow: 0;">Data:</label>
        <select name="filtro_admin" id="filtro" class="select select-bordered" style="flex-grow: 1;">
            <option value="tutte">Tutte</option>
            <option value="anno">Ultimo anno</option>
            <option value="mese">Ultimo Mese</option>
            <option value="settimana">Ultima Settimana</option>
            <option value="oggi">Oggi</option>
        </select>


        <label class="filter" style="flex-grow: 0;">Causa:</label>
        <select name="causa_filtro_admin" class="select select-bordered">
            <option disabled selected>Tutte</option>
            <?php foreach($cause as $causa) : ?>
            <option><?= $causa['tipologia'] ?></option>
            <?php endforeach; ?>
        </select>

        <label class="filter" style="flex-grow: 0;">Utente: </label>
        <select name="utente_admin" class="select select-bordered">
            <option disabled selected>Tutti</option>
            <?php foreach ($tutti_utenti as $username): ?>
            <option value="<?= $username['username']; ?>"><?= $username['username']; ?></option>
            <?php endforeach; ?>
        </select>




        <label class="filter" style="flex-grow: 0;">Ordina per: </label>
        <select name="ordine_filtro_admin" class="select select-bordered">
            <option value="data_piu_recente" selected>Data più recente</option>
            <option value="data_meno_recente">Data meno recente</option>
            <option value="importo_maggiore">Importo maggiore</option>
            <option value="importo_minore">Importo minore</option>
        </select>




        <input class="btn btn-primary" type="submit" value="Filtra tabella" style="flex-grow: 0; margin-left: 10px;">
    </form>


    <form class="form" action="index.php?action=reset_admin" method="post" style="display: inline-block;">
        <input class="btn btn-primary" type="submit" value="Reset" style="flex-grow: 0; margin-left: 10px;">
    </form>
</div>
<div>
    <label style="margin-top: 50px" class="label">Visualizza tutte le spese:</label>
    <table id="tabella-spese" class="table">
        <thead>
        <tr class="bg-base-200">
            <th>N</th>
            <th>Utente</th>
            <th>Importo (€)</th>
            <th>Causa</th>
            <th>File</th>
            <th>Data</th>
            <th>Ora</th>
            <th>Elimina</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <?php
                     $contatore = 1;
                     foreach($spese as $spesa) : ?>
        <tr>
            <td><?= $contatore ?></td>
            <td><?= $spesa['username'] ?></td>
            <td><?= $spesa['importo'] ?></td>
            <td><?= $spesa['tipologia'] ?></td>
            <?php if (!empty($spesa['fotoScontrino'])) : ?>
            <td><a href="<?= $spesa['fotoScontrino'] ?>" download>Scarica</a></td>
            <?php else : ?>
            <td></td>
            <?php endif; ?>
            <td><?= $spesa['data'] ?></td>
            <td><?= $spesa['orario'] ?></td>
            <td><a href="index.php?action=delete&id=<?= $spesa['id'] ?>" class="delete-link">
                    <button class="delete-button">
                        <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path d="M18.3 5.71a1 1 0 0 0-1.42 0L12 10.59 7.12 5.7A1 1 0 0 0 5.7 7.12l4.88 4.88-4.88 4.88a1 1 0 0 0 1.41 1.41L12 13.41l4.88 4.88a1 1 0 0 0 1.41-1.41L13.41 12l4.88-4.88a1 1 0 0 0 0-1.41z"/>
                        </svg>
                    </button>
                </a>
            </td>
        </tr>
        <?php
                  $contatore++;
                  endforeach;
                  ?>
        </tbody>
    </table>
</div>

<br><br><br><br>

<script>
    function validateForm() {
        resetPopUp();
        var password = document.getElementById("password").value;
        var confirm_password = document.getElementById("confirm_password").value;
        var errorMessage = document.getElementById("password-error");
        if (password !== confirm_password) {
            errorMessage.style.display = "block";
            return false;
        }

        errorMessage.style.display = "none";
        return true;
    }
    function resetPopUp() {
        var errorMessage = document.getElementById("error");
        var successfulMessage = document.getElementById("successful");
        if (errorMessage !== null) {
            errorMessage.style.display = "none";
        }

        if (successfulMessage !== null) {
            successfulMessage.style.display = "none";
        }
    }
</script>

</body>
</html>