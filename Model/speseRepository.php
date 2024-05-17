<?php

namespace Model;
use Util\Connection;
use \PDO;


class speseRepository
{
    public static function addPurchase($id_utente, $id_descrizione, $importo, $file, $orario, $data) {
        $pdo = Connection::getInstance();
        $sql = 'INSERT INTO note (id_descrizione, id_utente, importo, fotoScontrino, orario, data) 
        VALUES (:id_descrizione, :id_utente, :importo, :file, :orario, :data)';
        $stmt = $pdo->prepare($sql);

        $stmt->execute([
            'id_utente' => $id_utente,
            'id_descrizione' => $id_descrizione,
            'importo' => $importo,
            'file' => $file,
            'orario' => $orario,
            'data' => $data
        ]);

    }

    public static function getTipologies(){
        $pdo = Connection::getInstance();
        $sql = 'SELECT *
        FROM descrizione';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([

            ]
        );
        return $stmt->fetchAll();
    }
}