 <?php

  //authentication 

  class AuthDB
  {
    private PDOStatement $statementRegister;
    private PDOStatement $statementReadSession;
    private PDOStatement $statementReadUSer;
    private PDOStatement $statementReadUserFromEmail;
    private PDOStatement $statementCreateSession;
    private PDOStatement $statementDeleteSession;

    function __construct(private PDO $pdo)
    { // preparation des données pour l'authentication
      $this->statementRegister = $pdo->prepare('INSERT INTO user VALUES(
        DEFAULT,
        :firstname,
        :lastname, 
        :email,
        :password
      )');

      $this->statementReadSession = $pdo->prepare('SELECT * FROM session WHERE id=:id');
      $this->statementReadUSer = $pdo->prepare('SELECT * FROM user WHERE id=:id');
      $this->statementReadUserFromEmail = $pdo->prepare('SELECT * FROM USER WHERE email=:email');
      $this->statementCreateSession =  $pdo->prepare('INSERT INTO session VALUES (
        :sessionid,
        :userid
      )');
      $this->statementDeleteSession = $pdo->prepare('DELETE FROM session WHERE id=:id');
    }

    // reccuperation et protection de la session + temps de connexion automatique
    function login(string $userId): void
    {
      $sessionId = bin2hex(random_bytes(32));
      $this->statementCreateSession->bindValue(':userid', $userId);
      $this->statementCreateSession->bindValue(':sessionid', $sessionId);
      $this->statementCreateSession->execute();
      $signature = hash_hmac('sha256', $sessionId, 'cinq petits chats');
      setcookie('session', $sessionId, Time() + 60 * 60 * 24 * 14, '', '', false, true);
      setcookie('signature', $signature, Time() + 60 * 60 * 24 * 14, '', '', false, true);
      return;
    }

    function register(array $user): void
    {
      // enregistrement de l'utilisateur + hashage du mdp
      $hashPassword = password_hash($user['password'], PASSWORD_ARGON2I);
      $this->statementRegister->bindValue(':firstname', $user['firstname']);
      $this->statementRegister->bindValue(':lastname', $user['lastname']);
      $this->statementRegister->bindValue(':email', $user['email']);
      $this->statementRegister->bindValue(':password', $hashPassword);
      $this->statementRegister->execute();
      return;
    }

    function isLoggedin(): array | false
    {
      //connexion de l'utilisateur avec protection
      $sessionId = $_COOKIE['session'] ?? '';
      $signature = $_COOKIE['signature'] ?? '';

      if ($sessionId && $signature) {
        $hash = hash_hmac('sha256', $sessionId, 'cinq petits chats');
        if (hash_equals($hash, $signature)) {
          $this->statementReadSession->bindValue(':id', $sessionId);
          $this->statementReadSession->execute();
          $session = $this->statementReadSession->fetch();
          if ($session) {
            $this->statementReadUSer->bindValue(':id', $session['userid']);
            $this->statementReadUSer->execute();
            $user = $this->statementReadUSer->fetch();
          }
        }
      }
      return $user ?? false;
    }

    function logout(string $sessionId): void
    {
      //deconnexion
      $this->statementDeleteSession->bindValue(':id', $sessionId);
      $this->statementDeleteSession->execute();
      setcookie('session', '', time() - 1);
      setcookie('signature', '', time() - 1);
      return;
    }

    function getUserFromEmail(string $email): array | false
    {
      //reccupération du compte via le mail
      $this->statementReadUserFromEmail->bindValue(':email', $email);
      $this->statementReadUserFromEmail->execute();
      return $this->statementReadUserFromEmail->fetch();
    }
  }
  return new AuthDB($pdo);
