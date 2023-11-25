# Example React Project

## Requirements

- node.js

## setup

### Install dependencies

```sh
npm install
```

## Run the project in dev mode

By default, the file `env/.env.development` is loaded when running the project in dev mode. Make sure to check that everything is set correctly.

```sh
npm run dev
```

## Build the project in production mode

By default, when building the project in production mode, the file `env/.env.production` will be used. You should fill it with the necessary production information.

```sh
npm run build
```

# Travaux

## Minimum

- [ ] Docker
- [ ] CI : 
  - [ ] arrêt si une étape échoue
  - [x] tests unitaires
  - [x] _build_
  - [ ] mise en ligne du livrable (ex : DockerHub)
- [ ] déploiement sur Kubernetes

## Bonus
### Simples
- [ ] CI :
  - [x] linter
  - [x] pour _PR_
  - [ ] déploiement de _releases_ (sur des _tags_)
  - [x] calculer et afficher la couverture des tests unitaires dans les _PR_
  - [ ] déploiement sur Kubernetes (_pipeline_ peut être lancée manuellement)
  - [ ] déploiement sur Kubernetes avec Helm

### Longs
- [ ] CI :
  - [x] qualité de code (SonarCloud, ~~Code Climate~~)
  - [ ] afficher le rapport de qualité du code dans une _PR_ et bloquer la validation si en dessous d'un seuil
  - [ ] *pipeline* auto de tests automatiques (e2e, montée de charge)
  - [ ] création d'environnement à la volée


- [ ] ~~_healthcheck_ :~~
  - [ ] ~~ajout d'une route de _healthcheck_ sur le backend pour vérifier aprés déploiement~~
  - [ ] ~~ajout *pipeline* utilisant la route pour confirmer que le déploiement est correct~~


- [ ] outils: 
  - [ ] création outil communiquant avec une API GitHub/GitLab pour déployer le projet
  - [ ] monitoring (Prometheus)
  - [ ] gestion de logs (Elasticsearch)
