# Gestione spese su PHP

Questo progetto mostra un semplice esempio della gestione delle spese all'interno di un'azienda, utilizzando il linguaggio PHP.


## Passi per rendere il progetto funzionante sul proprio PC

1.  Scaricare questo progetto nel modo preferito (con git, come file zip, forkando il progetto...)
2. Importare il database che si trova nel file `localhost...sql` all'interno di un database, chiamandolo `gestione_spese`. Per importarlo con DataGrip si può andare nel menù contestuale "SQL scripts -> Run SQL script..." oppure nel menù "Import/Export -> Restore with mysql". In qualsiasi di questi due modi si dovrebbe arrivare ad avere le due tabelle `studente` e `valutazione` all'interno del database `autenticazione`.
3. Creare il file `config.php` nella cartella `conf` e copiare al suo interno il contenuto di `config.example.php`, modificando i valori delle costanti in modo che contengano i veri dati di connessione, ad esempio:
    ```php
    const DB_HOST = 'localhost';
    const DB_NAME = 'gestione_spese';
    const DB_USER = 'root';
    const DB_PASSWORD = '';
   ```
4. Verificare di avere installato `composer` sulla propria macchina, se non è presente scaricarlo dal sito e installarlo. Per verificare se è presente e funzionante aprire un terminale e digitare 
    ```php
    composer --version
    ```

    Se appare la versione vuol dire che va bene, altrimenti qualcosa è andato storto. Se si utilizza il terminale integrato in PHPStorm è necessario riavviarlo per rendere visibile `composer`.
5. Eseguire i seguenti comandi
   
    ```php
    composer update
    composer dump-autoload
    ```
    verrà in questo modo creata la cartella `vendor` con all'interno tutte le librerie.

## Funzionalità progetto
In questo progetto, molto brevemente, vi è la presenza di due soggetti principali: l'utente (il dipendente dell'azienda) e l'admin (responsabile).
Il dipende può effetturare il login e, successivamente, poter aggiungere una spesa indicando l'importo, la data e ora, il motivo e un'immagine.
Invece, l'admin ha la funzionalità di aggiungere un nuovo utente e visualizzare tutte le spese memorizzate nel database.
