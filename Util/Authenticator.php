<?php

namespace Util;

use Model\UserRepository;

/**
 * Classe per gestire l'autenticazione
 */
class Authenticator{

    private function __construct()
    {
    }

    /**

     */
    private static function start()
    {
        if (session_id() == "")
            session_start();
    }

    public static function getUser():array|null{
        self::start();
        //Controllo se è in corso un tentativo di login
        //verificando la presenza dello username spedito tramite POST
        if (isset($_POST['username'])){
            $username = $_POST['username'];
            $password = $_POST['password'];

            $row = UserRepository::userAuthentication($username, $password);

            if ($row != null) {
                $_SESSION['user'] = $row;
            }
        }

        if (!isset($_SESSION['user']))
                return null;
        return $_SESSION['user'];
    }

    public static function logout()
    {
        self::start();
        //Distrugge la sessione per evitare che parti successive del codice
        //nello stesso script la utilizzino
        $_SESSION = [];
        //Distrugge la sessione sul server
        session_destroy();
    }


}