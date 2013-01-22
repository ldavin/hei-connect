# HEI Connect

[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/ldavin/hei-connect)

## Présentation

### En bref
Pour faire simple, HEI-Connect est un script qui récupère des informations depuis [e-campus](http://e-campus.hei.fr/KonosysProd/), et les retourne dans un format informatique générique (`JSON`).  L'intérêt est que n'importe quelle application (web, iphone, android...) peut communiquer avec HEI-Connect, et ainsi présenter à l'utilisateur son planning, ses notes et ses absences HEI.

### En détails
Plus précisément, HEI-Connect est une API écrite en [Ruby](http://www.ruby-lang.org/fr/), utilisant le framework [Rails](http://rubyonrails.org/).
L'API utilise [HtmlUnit](http://htmlunit.sourceforge.net/), à travers la gem [celerity](http://celerity.rubyforge.org/), pour simuler une visite sur e-campus, s'y logger, et récupérer différentes informations (emploi du temps, notes, absences...) afin de les retourner en JSON.

##### Pourquoi passer par HtmlUnit ?
Quelle que soit la méthode utilisée (commande `curl`, script en java ou autre), le serveur d'e-campus renverra une erreur 500, comme s'il parvenait à bloquer toute requête ne provenant pas d'un vrai navigateur. On utilise donc HtmlUnit, qui (grossièrement) permet de simuler un navigateur internet sans fenêtre.

##### HtmlUnit est une bibliothèque JAVA, or l'API est en Ruby ?
L'API tourne en réalité sur [JRuby](http://jruby.org/), qui permet d'interpréter le code ruby depuis la JVM, et ainsi créer des interconnections entre le code Ruby et Java. La gem celerity facilite ce travail, et permet de jouer avec HtmlUnit comme si c'était une bibliothèque Ruby classique.

## Documentation
Avant la rédaction d'une vraie documentation, il est possible de [jouer avec l'API grâce dans une console web](https://apigee.com/ldavin/embed/console/hei-connect). Toutes les méthodes de l'API sont listées. En remplaçant les exemples par de vrais identifiants e-campus, il est possible de d'appeler l'API et de voir comment elle réagit.

## Les projets autour d'HEI-Connect
### HEI-Connect
L'API de base permettant de récupérer en JSON des données depuis e-campus.
[Projet GitHub](https://github.com/ldavin/hei-connect)

### [HEI-Connect-Web](http://www.hei-connect.eu)
Une application web communiquant avec HEI-Connect, visant à créer un e-campus "parallèle", plus rapide, plus simple d'utilisation, avec de nouvelles fonctionnalités.
[Projet GitHub](https://github.com/ldavin/hei-connect-web)
