# HEI E-Campus API

## What is this?

Une api écrite en Ruby basée sur le microframework [Grape](http://github.com/intridea/grape).
L'api utilise HtmlUnit, à travers la gem [celerity](http://celerity.rubyforge.org/), pour simuler une visite sur [e-campus](http://e-campus.hei.fr/KonosysProd/), s'y logger, et récupérer différentes informations (emploi du temps, notes, absences...) afin de les retourner en JSON.

A terme, en utilisant cette api, il sera possible de créer des applications web, iphone, android... accédant au contenu d'e-campus.

## To do

WIP

* Implémenter des fonctionnalités de base (lecture du planning, lecture des notes, lecture des absences)
* Se former sur les tests et en implémenter
* Documenter l'API