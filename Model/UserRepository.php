<?php

namespace Model;
use Util\Connection;

class UserRepository{

    public static function userAuthentication(string $username, string $password):array|null{
        $pdo = Connection::getInstance();
        $sql = 'SELECT * FROM utente WHERE username=:username';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
                'username' => $username
            ]
        );

        if($stmt->rowCount() == 0){
            return null;
        }

        $row = $stmt->fetch();
        if (!password_verify($password, $row['password'])) {

            return null;
        }
        return $row;
    }

    public static function getCause(){
        $pdo = Connection::getInstance();
        $sql = 'SELECT * FROM descrizione';
        $stmt = $pdo->prepare($sql);
        $stmt->execute();
        $result = $stmt->fetchAll();
        return $result;
    }


    public static function getSpesefiltrate($id, $filtro_data, $causa_filtro, $order_by)
    {
        $pdo = Connection::getInstance();
        $sql = 'SELECT note.id ,tipologia, data, orario, fotoScontrino, importo
        FROM descrizione, note
        WHERE note.id_descrizione = descrizione.id
          AND note.id_utente = :id
          AND tipologia LIKE :causa_filtro';

        switch ($filtro_data) {
            case 'oggi':
                $sql .= ' AND note.data = CURRENT_DATE()';
                break;
            case 'settimana':
                $sql .= ' AND note.data >= DATE_SUB(CURDATE(), INTERVAL 7 DAY) AND note.data <= CURDATE()';
                break;
            case 'mese':
                $sql .= ' AND note.data >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH) AND note.data <= CURDATE()';
                break;
            case 'anno':
                $sql .= ' AND note.data >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR) AND note.data <= CURDATE()';
                break;
            default:
                break;
        }

        switch ($order_by) {
            case 'data_piu_recente':
                $sql .= ' ORDER BY note.data DESC';
                break;
            case 'data_meno_recente':
                $sql .= ' ORDER BY note.data ASC';
                break;
            case 'importo_maggiore':
                $sql .= ' ORDER BY note.importo DESC';
                break;
            case 'importo_minore':
                $sql .= ' ORDER BY note.importo ASC';
                break;
            default:
                break;
        }

        $causa_filtro = "%{$causa_filtro}%";

        $params = ['id' => $id, 'causa_filtro' => $causa_filtro];
        $stmt = $pdo->prepare($sql);
        $stmt->execute($params);
        return $stmt->fetchAll();
    }

    public static function checkUserExists(string $username): ?array {
        $pdo = Connection::getInstance();
        $sql = 'SELECT * FROM spese2.utente WHERE username=:username';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
            'username' => $username
        ]);

        // Se non esiste un utente con lo stesso nome utente, restituisci null
        if ($stmt->rowCount() == 0) {
            return null;
        }

        // Se esiste un utente con lo stesso nome utente, restituisci i dati dell'utente
        return $stmt->fetch();
    }
    public static function checkMatricolaExists(string $matricola): ?array {
        $pdo = Connection::getInstance();
        $sql = 'SELECT * FROM spese2.utente WHERE matricola=:matricola';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
            'matricola' => $matricola
        ]);

        // Se non esiste un utente con lo stesso nome utente, restituisci null
        if ($stmt->rowCount() == 0) {
            return null;
        }

        // Se esiste un utente con lo stesso nome utente, restituisci i dati dell'utente
        return $stmt->fetch();
    }
    public static function checkEmailExists(string $email): ?array {
        $pdo = Connection::getInstance();
        $sql = 'SELECT * FROM spese2.utente WHERE email=:email';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
            'email' => $email
        ]);

        // Se non esiste un utente con lo stesso nome utente, restituisci null
        if ($stmt->rowCount() == 0) {
            return null;
        }

        // Se esiste un utente con lo stesso nome utente, restituisci i dati dell'utente
        return $stmt->fetch();
    }
    public static function addUser(string $username, string $password , string $nome, string $cognome , string $email , int $matricola)
    {
        $pdo = Connection::getInstance();
        $encryptedPassword = password_hash($password, PASSWORD_DEFAULT);
        $sql = 'INSERT INTO spese2.utente (username, password ,nome ,cognome, matricola,email) 
            VALUES (:username , :password , :nome , :cognome , :matricola , :email)';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
                'username' => $username,
                'password' => $encryptedPassword,
                'nome' => $nome,
                'cognome' =>$cognome,
                'email' =>$email ,
                'matricola' =>$matricola
            ]
        );
    }






    public static function getSpeseAdmin($filtro_data, $causa_filtro, $order_by, $utente)
    {
        $pdo = Connection::getInstance();
        $sql = 'SELECT note.id ,tipologia, note.data, orario, fotoScontrino, importo, username
            FROM descrizione
            JOIN note ON note.id_descrizione = descrizione.id
            JOIN utente ON utente.id = note.id_utente
            WHERE tipologia LIKE :causa_filtro';

        if ($utente !== 'tutti') {
            $sql .= ' AND utente.username = :utente';
        }

        switch ($filtro_data) {
            case 'oggi':
                $sql .= ' AND DATE(note.data) = CURRENT_DATE()';
                break;
            case 'settimana':
                $sql .= ' AND note.data >= DATE_SUB(CURDATE(), INTERVAL 7 DAY) AND note.data <= CURDATE()';
                break;
            case 'mese':
                $sql .= ' AND note.data >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH) AND note.data <= CURDATE()';
                break;
            case 'anno':
                $sql .= ' AND note.data >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR) AND note.data <= CURDATE()';
                break;
            default:
                break;
        }

        switch ($order_by) {
            case 'data_piu_recente':
                $sql .= ' ORDER BY note.data DESC';
                break;
            case 'data_meno_recente':
                $sql .= ' ORDER BY note.data ASC';
                break;
            case 'importo_maggiore':
                $sql .= ' ORDER BY note.importo DESC';
                break;
            case 'importo_minore':
                $sql .= ' ORDER BY note.importo ASC';
                break;
            default:
                break;
        }

        $causa_filtro = "%{$causa_filtro}%";
        $params = ['causa_filtro' => $causa_filtro];

        // Aggiungi il parametro dell'utente solo se non è impostato su 'tutti'
        if ($utente !== 'tutti') {
            $params['utente'] = $utente;
        }

        $stmt = $pdo->prepare($sql);
        $stmt->execute($params);
        return $stmt->fetchAll();
    }


    public static function getDistinctUsernames()
    {
        $pdo = Connection::getInstance();
        $sql = 'SELECT DISTINCT username FROM utente';
        $stmt = $pdo->query($sql);
        return $stmt->fetchAll();
    }
    public static function getUsers()
    {
        $pdo = Connection::getInstance();
        $sql = 'SELECT * FROM spese2.utente order by matricola';
        $stmt = $pdo->query($sql);
        return $stmt->fetchAll();
    }





}