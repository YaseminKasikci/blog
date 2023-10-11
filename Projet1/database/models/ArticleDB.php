<?php

//crud article ( creation, modification, suppression, lecture des donnees)

class ArticleDB
{
  private PDOStatement $statementCreateOne;
  private PDOStatement $statementUptadeOne;
  private PDOStatement $statementDeleteOne;
  private PDOStatement $statementReadOne;
  private PDOStatement $statementReadAll;
  private PDOStatement $statementReadUserAll;

  function __construct(private PDO $pdo)
  {
    //création d'un artiche dans la DB
    $this->statementCreateOne = $pdo->prepare('
  INSERT INTO article(
    title,
    category,
    content,
    image,
    author
  ) VALUES (
    :title,
    :category,
    :content,
    :image,
    :author
    )
');

    //modification des articles dans la DB
    $this->statementUptadeOne = $pdo->prepare('
      UPDATE article 
      SET 
          title = :title,
          category = :category,
          content = :content,
          image = :image,
          author = :author
        WHERE id=:id

');
    // preparation des elements à partir de la DB,
    $this->statementReadOne = $pdo->prepare('SELECT article.*, user.firstname, user.lastname FROM article LEFT JOIN user ON article.author = user.id WHERE article.id=:id');
    $this->statementReadAll = $pdo->prepare('SELECT article.*, user.firstname, user.lastname FROM article LEFT JOIN user ON article.author = user.id');
    $this->statementDeleteOne = $pdo->prepare('DELETE FROM article WHERE id=:id');
    $this->statementReadUserAll = $pdo->prepare('SELECT * FROM article WHERE author=:authorId');
  }

  public function fetchAll(): array
  {
    // reccupération de tout les articles + nom, prénom de l'auteur
    $this->statementReadAll->execute();
    return $this->statementReadAll->fetchAll();
  }
  public function fetchOne(string $id): array
  {
    //recuperation d'un article + nom, prénom de l'auteur
    $this->statementReadOne->bindValue(':id', $id);
    $this->statementReadOne->execute();
    return $this->statementReadOne->fetch();
  }
  public function deleteOne(string $id): string
  {
    //suppression de l'article
    $this->statementDeleteOne->bindValue(':id', $id);
    $this->statementDeleteOne->execute();
    return $id;
  }
  public function createOne($article): array
  {
    //creation de l'article
    $this->statementCreateOne->bindValue(':title', $article['title']);
    $this->statementCreateOne->bindValue(':image',  $article['image']);
    $this->statementCreateOne->bindValue(':category',  $article['category']);
    $this->statementCreateOne->bindValue(':content',  $article['content']);
    $this->statementCreateOne->bindValue(':author',  $article['author']);
    $this->statementCreateOne->execute();
    return $this->fetchOne($this->pdo->lastInsertId());
  }
  public function updateOne($article): array
  {
    //modification de l'article
    $this->statementUptadeOne->bindValue(':title', $article['title']);
    $this->statementUptadeOne->bindValue(':image', $article['image']);
    $this->statementUptadeOne->bindValue(':category', $article['category']);
    $this->statementUptadeOne->bindValue(':content', $article['content']);
    $this->statementUptadeOne->bindValue(':id', $article['id']);
    $this->statementUptadeOne->bindValue(':author',  $article['author']);
    $this->statementUptadeOne->execute();
    return $article;
  }

  public function fetchUserArticle(string $authorId): array
  {
    // reccuperation de l'autheur et son article
    $this->statementReadUserAll->bindValue(':authorId', $authorId);
    $this->statementReadUserAll->execute();
    return $this->statementReadUserAll->fetchAll();
  }
}

return new ArticleDB($pdo);
