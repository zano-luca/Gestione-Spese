<?php

require_once "vendor/autoload.php";
require_once "conf/config.php";

use League\Plates\Engine;
use Util\Authenticator;

$template = new Engine("templates", "tpl");
$user = Authenticator::getUser();


if ($user == null){
    if (isset($_POST['login_attempt'])){
        $login_fallito = true;
        echo $template->render('index', [
                'login_fallito' => $login_fallito
            ]
        );
    }
    else {
        echo $template->render('index');
    }
    exit(0);
}



$cause = \Model\UserRepository::getCause();
$display_name = $user['username'];


$tutti_utenti = Model\UserRepository::getDistinctUsernames();
foreach ($tutti_utenti as $key => $utente) {
    if ($utente['username'] === "admin") {
        unset($tutti_utenti[$key]);
    }
}


//parametri di default
$filtro_data = "tutte";
$causa_filtro = "";
$order_by = "data_piu_recente";

$spese = Model\UserRepository::getSpesefiltrate(
    $user["id"],
    $filtro_data,
    $causa_filtro,
    $order_by
);

//sostituire il file in binario in png
$i = 0;
foreach ($spese as $row) {
    if (!empty($row["fotoScontrino"])) {
        $imageSrc = "data:image/jpeg;base64," . base64_encode($row["fotoScontrino"]);
        $spese[$i]["fotoScontrino"] = $imageSrc;
    }
    $i++;
}

if (isset($_POST)) {
    if (isset($_POST["importo"]) && isset($_FILES["file"])) {
        $importo = $_POST["importo"];
        $data = $_POST["data"];
        $orario = $_POST["orario"];
        $causa = $_POST["causa"];

        $filename = $_FILES["file"]["tmp_name"];
        $imgData = file_get_contents($filename);
        $size = getimagesize($filename);

        $id_causa = null;
        foreach ($cause as $elemento) {
            if ($elemento["tipologia"] === $causa) {
                $id_causa = $elemento["id"];
                break;
            }
        }

        Model\speseRepository::addPurchase(
            $user["id"],
            $id_causa,
            $importo,
            $imgData,
            $orario,
            $data
        );
    }
}

if (isset($_POST)) {
    if (isset($_POST["filtro"])) {
        $data_filtro = $_POST["filtro"];

        if (isset($_POST["causa_filtro"])) {
            $causa_filtro = $_POST["causa_filtro"];
        } else {
            $causa_filtro = "";
        }

        if (isset($_POST["ordine_filtro"])) {
            $ordine_filtro = $_POST["ordine_filtro"];
        } else {
            $ordine_filtro = "data_piu_recente";
        }

        $spese = Model\UserRepository::getSpesefiltrate(
            $user["id"],
            $data_filtro,
            $causa_filtro,
            $ordine_filtro
        );
        $i = 0;
        foreach ($spese as $row) {
            if (!empty($row["fotoScontrino"])) {
                $imageSrc = "data:image/jpeg;base64," . base64_encode($row["fotoScontrino"]);
                $spese[$i]["fotoScontrino"] = $imageSrc;
            }
            $i++;
        }
    }
}

if (isset($_GET["action"])) {
    if ($_GET["action"] == "login") {
        echo $template->render("spesa", [
            "spese" => $spese,
            "cause" => $cause,
            "name" => $display_name,
        ]);
        exit(0);
    }

    if ($_GET["action"] == "reset") {
        $filtro = "tutte";
        $causa_filtro = "";
        echo $template->render("spesa", [
            "spese" => $spese,
            "cause" => $cause,
            "name" => $display_name,

        ]);
        exit(0);

    }
    if($_GET["action"] == 'delete'){
        $id_spesa = $_GET["id"];
        Model\speseRepository::deletePurchase($id_spesa);
        header("Location: index.php");
    }
    if ($_GET["action"] == "logout") {
        Authenticator::logout();
        $templateData = [
            "errore" => "",
        ];
        echo $template->render("index", $templateData);
        exit(0);
    }

    if ($_GET["action"] == "fine") {
        echo $template->render("fine");
        exit(0);
    }
}




if ($user['username']=='admin'){
$users= Model\UserRepository::getUsers();
//parametri di default
    $filtro_data = "tutte";
    $causa_filtro = "";
    $order_by = "data_piu_recente";

    $utenti = "tutti";

    $spese = Model\UserRepository::getSpeseAdmin(
        $filtro_data,
        $causa_filtro,
        $order_by,
        $utenti
    );

//sostituire il file in binario in png
    $i = 0;
    foreach ($spese as $row) {
        if (!empty($row["fotoScontrino"])) {
            $imageSrc = "data:image/jpeg;base64," . base64_encode($row["fotoScontrino"]);
            $spese[$i]["fotoScontrino"] = $imageSrc;
        }
        $i++;
    }


    if (isset($_GET["action"])) {
        if ($_GET["action"] == "reset_admin") {
            $filtro_data = "tutte";
            $causa_filtro = "";
            $order_by = "data_piu_recente";
        }

    }

    if (isset($_POST["filtro_admin"])) {
        $data_filtro = $_POST["filtro_admin"];

        if (isset($_POST["causa_filtro_admin"])) {
            $causa_filtro = $_POST["causa_filtro_admin"];
        } else {
            $causa_filtro = "";
        }

        if (isset($_POST["ordine_filtro_admin"])) {
            $ordine_filtro = $_POST["ordine_filtro_admin"];
        } else {
            $ordine_filtro = "data_piu_recente";
        }

        if (isset($_POST["utente_admin"])){

            $utenti = $_POST["utente_admin"];
        }else $utenti = "tutti";

        $spese = Model\UserRepository::getSpeseAdmin(
            $data_filtro,
            $causa_filtro,
            $ordine_filtro,
            $utenti
        );

        $i = 0;
        foreach ($spese as $row) {
            if (!empty($row["fotoScontrino"])) {
                $imageSrc = "data:image/jpeg;base64," . base64_encode($row["fotoScontrino"]);
                $spese[$i]["fotoScontrino"] = $imageSrc;
            }
            $i++;
        }
    }

    if (isset($_GET['action'])){
        if (($_GET['action']) == 'logout'){
            Authenticator::logout();
            echo $template->render('login');
            exit(0);
        }
        else if($_GET["action"] == 'delete'){
            $id_spesa = $_GET["id"];
            Model\speseRepository::deletePurchase($id_spesa);
            header("Location: index.php");
        }
    }

    if (isset($_POST['NewUsername'])){
        $username = $_POST['NewUsername'];
        $password = $_POST['NewPassword'];
        $email =$_POST['email'];
        $nome =$_POST['nome'];
        $cognome =$_POST['cognome'];
        $matricola=$_POST['matricola'];

        if(Model\UserRepository::checkUserExists($username)==null && Model\UserRepository::checkMatricolaExists($matricola)==null && Model\UserRepository::checkEmailExists($email)==null){
            Model\UserRepository::addUser($username,$password,$nome,$cognome,$email,$matricola);
            echo $template->render('controlPanel' , [
                'successful' => true,
                'tutti_utenti' => $tutti_utenti,
                'users' =>$users,
                'spese' => $spese

            ]);
        }
        else {
            echo $template->render('controlPanel' , [
                'successful' => false,
                'tutti_utenti' => $tutti_utenti,
                'users' =>$users,
                'spese' => $spese



            ]);
        }
        exit(0);
    }


    echo $template->render('controlPanel' , [
        'spese' => $spese,
        'cause' => $cause,
        'tutti_utenti' => $tutti_utenti,
        'users' =>$users
    ]);
    exit(0);
}

echo $template->render("spesa", [
    "spese" => $spese,
    "cause" => $cause,
    "name" => $display_name,

]);
