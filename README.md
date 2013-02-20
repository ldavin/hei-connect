# HEI Connect

[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/ldavin/hei-connect)

## Présentation

### En bref
Pour faire simple, HEI-Connect est un script qui récupère des informations depuis [e-campus](http://e-campus.hei.fr/KonosysProd/), et les retourne dans un format informatique générique (`JSON`).  L'intérêt est que n'importe quelle application (web, iphone, android...) peut communiquer avec HEI-Connect, et ainsi présenter à l'utilisateur son planning, ses notes et ses absences HEI.

### En détails
Plus précisément, HEI-Connect est une API écrite en [Ruby](http://www.ruby-lang.org/fr/), utilisant le framework [Rails](http://rubyonrails.org/).
L'API utilise [Mechanize](http://mechanize.rubyforge.org/) pour simuler une visite sur e-campus, s'y logger, et récupérer différentes informations (emploi du temps, notes, absences...) en les lisant dans le code source de la page, afin de les retourner en JSON.

## Documentation
Avant la rédaction d'une vraie documentation, il est possible de [jouer avec l'API dans une console web](https://apigee.com/ldavin/embed/console/hei-connect). Toutes les méthodes de l'API sont listées. En remplaçant les données d'exemple par de vrais identifiants e-campus, il est possible d'appeler l'API et de voir comment elle réagit.

## Les projets autour d'HEI-Connect
### HEI-Connect
L'API de base permettant de récupérer en JSON des données depuis e-campus.
[Projet GitHub](https://github.com/ldavin/hei-connect)

### [HEI-Connect-Web](http://www.hei-connect.eu)
Une application web communiquant avec HEI-Connect, visant à créer un e-campus "parallèle", plus rapide, plus simple d'utilisation, avec de nouvelles fonctionnalités.
[Projet GitHub](https://github.com/ldavin/hei-connect-web)
