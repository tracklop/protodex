# ProtoDex

## Membres du Projet

- **Otuszewski Hugo**
- **Soltysiak Clément**

## Description du Projet

ProtoDex est une application mobile développée en Flutter qui sert de prototype de Pokédex. Elle utilise l'API publique [PokeAPI](https://pokeapi.co/) pour récupérer les données sur les Pokémon et permet aux utilisateurs de naviguer à travers la liste complète des Pokémon, de consulter les détails de chaque Pokémon, de marquer des Pokémon comme favoris ou capturés, et de suivre leur progression.

### Fonctionnalités Principales

- **Liste des Pokémon avec Défilement Infini** : Affiche les Pokémon par lots, chargeant automatiquement plus de Pokémon au fur et à mesure que l'utilisateur fait défiler la liste.
- **Détails des Pokémon** : Affiche des informations détaillées pour chaque Pokémon, y compris :
  - **Types**
  - **Capacités**
  - **Statistiques**
- **Marquer comme Favori** : Possibilité de marquer des Pokémon comme favoris directement depuis la liste ou depuis la page de détails. Les favoris sont enregistrés et consultables dans une page dédiée.
- **Marquer comme Capturé** : Possibilité de marquer des Pokémon comme capturés. Une page dédiée affiche la liste des Pokémon capturés et indique la progression de l'utilisateur par rapport au nombre total de Pokémon disponibles.
- **Progression de Capture** : Affichage du pourcentage de Pokémon capturés par rapport au nombre total, aidant l'utilisateur à suivre sa progression.
- **Gestion de l'État avec Provider** : Utilisation du package `provider` pour une gestion efficace de l'état de l'application.
- **Architecture MVVM** : Application de l'architecture Model-View-ViewModel pour une meilleure séparation des préoccupations et une maintenance facilitée.
- **Persistance des Données** : Sauvegarde des favoris et des Pokémon capturés entre les sessions grâce à `shared_preferences`.

## Installation et Exécution

### Prérequis

- Flutter SDK installé sur votre machine. (Version recommandée : **3.16**)
- Un simulateur ou un appareil physique pour tester l'application.

### Étapes d'Installation

1. **Cloner le Dépôt**

   ```bash
   git clone https://...
   cd protodex
   ```

2. **Installer les Dépendances**

   ```bash
   flutter pub get
   ```

3. **Exécuter l'Application**

   ```bash
   flutter run
   ```

## Structure du Projet

- `lib/models/` : Contient les classes de modèles de données (e.g., `Pokemon`, `PokemonListItem`).
- `lib/viewmodels/` : Contient les ViewModels pour la gestion de l'état (e.g., `PokemonListViewModel`, `FavoritesViewModel`, `CapturedViewModel`).
- `lib/views/` : Contient les widgets des vues (e.g., `PokemonListView`, `PokemonDetailView`, `FavoritesView`, `CapturedView`).
- `lib/services/` : Contient les services pour les appels à l'API (e.g., `PokeApiService`).

## Fonctionnement de l'Application

### Liste des Pokémon

- **Défilement Infini** : La liste charge les Pokémon par lots de 20. Lorsqu'on atteint la fin de la liste, les 20 prochains Pokémon sont chargés automatiquement.
- **Images des Pokémon** : Les images sont chargées depuis le dépôt des sprites de Pokémon. Si une image n'est pas disponible, une image de remplacement (placeholder) est affichée.

### Détails des Pokémon

- **Informations Affichées** :
  - Numéro du Pokémon
  - Nom
  - Types
  - Capacités
  - Statistiques de base
- **Actions Disponibles** :
  - Marquer comme Favori
  - Marquer comme Capturé

### Favoris et Capturés

- **Marquage Rapide** : Depuis la liste principale, il est possible de marquer un Pokémon comme favori ou capturé en cochant les cases correspondantes.
- **Pages Dédiées** :
  - **Favoris** : Affiche la liste des Pokémon marqués comme favoris, avec le nombre total de favoris en haut de la page.
  - **Capturés** : Affiche la liste des Pokémon capturés, avec un indicateur de progression en pourcentage basé sur le nombre total de Pokémon disponibles.

## Difficultés Rencontrées

- **Gestion des Images Manquantes** : Certains Pokémon, en particulier ceux avec des IDs supérieurs à 10000 (formes alternatives), n'ont pas d'images disponibles à l'URL standard. Pour résoudre ce problème, nous avons :
  - Ignoré les Pokémon avec des IDs supérieurs à 10000 lors du chargement de la liste.
  - Mis en place un gestionnaire d'erreur lors du chargement des images pour afficher un placeholder si nécessaire.
- **Défilement Infini** : L'implémentation du défilement infini a nécessité une gestion soignée du chargement asynchrone des données et de la mise à jour de l'interface utilisateur.
- **Persistance des Données** : L'utilisation de `shared_preferences` pour sauvegarder les favoris et les Pokémon capturés a été mise en place pour assurer que les données de l'utilisateur sont conservées entre les sessions.

## Informations Utiles

- **API Utilisée** : [PokeAPI](https://pokeapi.co/)
- **Packages Principaux** :
  - `provider` : Gestion de l'état.
  - `http` : Requêtes HTTP pour communiquer avec l'API.
  - `shared_preferences` : Persistance des données locales.

