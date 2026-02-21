
# Mini-Projet Big Data

## 1. ÉNONCÉ OFFICIEL DU MINI-PROJET

### Intitulé du projet
**Conception et mise en œuvre d'une mini-chaîne Big Data basée sur Hadoop**

### Objectifs pédagogiques
Ce mini-projet a pour objectif de consolider les connaissances acquises dans le cours Big Data, à savoir :
- Comprendre et manipuler HDFS
- Mettre en œuvre une ingestion de données avec Apache Flume
- Importer des données depuis une base relationnelle avec Apache Sqoop
- Développer et exécuter des traitements MapReduce avec Hadoop Streaming
- Comprendre l'architecture globale d'un pipeline Big Data

### Contexte
Vous êtes data engineers dans une entreprise disposant de plusieurs sources de données :
- Des logs applicatifs générés en continu
- Une base de données relationnelle (MySQL) contenant des données structurées

L'entreprise souhaite centraliser ces données dans HDFS et réaliser une analyse simple à l'aide de MapReduce.

### Technologies imposées
- Hadoop (HDFS + YARN)
- Apache Flume
- Apache Sqoop
- Hadoop Streaming (Python)
- Linux / Ubuntu

---

## 2. TRAVAIL DEMANDÉ

### Étape 1 – Préparation de l'environnement (HDFS)
- Démarrer les services Hadoop (DFS et YARN)
- Créer l'arborescence suivante dans HDFS :
  ```
  /user/hadoopuser/project/
   ├── logs/
   ├── db_data/
   ├── input/
   └── output/
  ```

### Étape 2 – Ingestion de logs avec Apache Flume
- Créer un script Python générant des logs aléatoires
- Configurer un agent Flume :
  - **Source** : exec
  - **Channel** : memory
  - **Sink** : HDFS
- Ingestions des logs dans le dossier `/project/logs`
- Vérifier les fichiers générés dans HDFS

### Étape 3 – Ingestion de données MySQL avec Apache Sqoop
- Installer et configurer MySQL et Sqoop
- Importer une table depuis MySQL vers HDFS dans `/project/db_data`
- Utiliser :
  - Un séparateur personnalisé
  - Un filtre (WHERE)
  - Au moins 2 ou 3 mappers

### Étape 4 – Traitement MapReduce
- Développer un mapper et un reducer en Python
- Exemples de traitements possibles :
  - Comptage du nombre de logs par action
  - WordCount sur les messages logs
  - Comptage d'enregistrements par catégorie
- Exécuter le job MapReduce avec Hadoop Streaming
- Stocker les résultats dans `/project/output`

### Étape 5 – Analyse des résultats
- Visualiser les résultats MapReduce
- Interpréter les résultats obtenus
- Répondre à des questions simples liées aux données

---

## 3. SQUELETTE DU RAPPORT (WORD / PDF)

### Page de garde
- Université / École
- Filière / Module
- Intitulé du projet
- Nom & Prénom
- Année universitaire

### Introduction
- Contexte du Big Data
- Objectif du mini-projet

### Chapitre 1 – Architecture globale du projet
- Description du pipeline Big Data
- Rôle de chaque technologie
- Schéma global (optionnel)

### Chapitre 2 – Ingestion des données

#### 2.1 Ingestion avec Apache Flume
- Configuration de l'agent
- Nature des logs générés

#### 2.2 Ingestion avec Apache Sqoop
- Structure de la base MySQL
- Commandes Sqoop utilisées

### Chapitre 3 – Traitement MapReduce
- Principe Map → Shuffle → Reduce
- Description du mapper
- Description du reducer
- Lancement du job

### Chapitre 4 – Résultats et analyse
- Résultats obtenus
- Interprétation
- Difficultés rencontrées

### Conclusion
- Synthèse du travail réalisé
- Apports pédagogiques
- Perspectives d'amélioration

### Références
- Documentation Hadoop
- Documentation Flume
- Documentation Sqoop

---

## 4. BARÈME DE NOTATION (/20)

| Critère | Points |
|---------|--------|
| Mise en place HDFS & structure | 3 pts |
| Ingestion avec Flume | 4 pts |
| Ingestion avec Sqoop | 4 pts |
| Traitement MapReduce | 5 pts |
| Analyse & interprétation | 2 pts |
| Qualité du rapport | 2 pts |
| **Total** | **20 pts** |
