# MiniMind - Documentation Technique

## 1. Fonctionnement de l'Application

### Vue d'ensemble
MiniMind est une application pédagogique qui initie les jeunes à l'IA et au développement durable à travers 4 modules interactifs.

### Architecture
- **Framework** : Flutter (Dart)
- **Structure** : Architecture MVC simplifiée
- **Navigation** : Routes nommées

### Modules
1. **Chatbot NLP** : Traitement du langage naturel
2. **Vision CNN** : Reconnaissance d'images
3. **Classification ML** : Apprentissage supervisé
4. **Prédiction Agricole** : Modèle prédictif

## 2. Modèles IA Utilisés

### Chatbot (NLP)
- **Type** : Pattern matching basique
- **Méthode** : Recherche par mots-clés
- **Base de connaissances** : Map<String, String> en dur
- **Pourquoi** : Simple à comprendre pour débutants

### Vision par Ordinateur (CNN)
- **Type** : Simulation de réseau convolutif
- **Étapes** : Prétraitement → Convolution → Pooling → Classification
- **Données** : Images locales (assets)
- **Pourquoi** : Visualisation du processus CNN

### Classification ML
- **Type** : Apprentissage supervisé simulé
- **Catégories** : Nature, Déchets, Pollution
- **Méthode** : Classification par règles
- **Pourquoi** : Concept d'entraînement/test

### Prédiction Agricole
- **Type** : Arbre de décision simplifié
- **Variables** : Température, humidité, pluie, sol
- **Cultures** : Riz, Blé, Maïs, Tomate, Arachide
- **Pourquoi** : IA au service de l'environnement

## 3. Source des Données

| Module | Type de données | Source |
|--------|----------------|---------|
| Chatbot | Base de connaissances | Définie manuellement |
| Vision CNN | Images | Assets locaux |
| Classification | Images de test | Assets locaux |
| Agriculture | Paramètres météo | Input utilisateur |

**Note** : Pas de modèle ML réel pour des raisons de simplicité pédagogique.

## 4. Étapes de Réalisation

### Phase 1 : Conception 
- Définition des modules
- Maquettes UI/UX
- Architecture de navigation

### Phase 2 : Développement 
- Page Intro avec animations
- Dashboard avec navigation
- Module Chatbot NLP
- Module Vision CNN
- Module Classification
- Module Prédiction Agricole

### Phase 3 : Design 
- Système de couleurs écoresponsable
- Animations de texte
- Interface cohérente

### Phase 4 : Tests 
- Tests utilisateur
- Corrections de bugs
- Optimisations

## 5. Difficultés Rencontrées

### Technique
- **Animations** : Synchronisation AnimatedTextKit
- **Images** : Gestion du cache et optimisation
- **Navigation** : Routes et états

### Pédagogique
- **Simplification** : Expliquer l'IA sans jargon
- **Interactivité** : Rendre l'apprentissage ludique
- **Équilibre** : IA + Écologie

### Solutions
- Utilisation de `DefaultTextStyle` pour animations
- Optimisation images avec `cacheWidth/Height`
- Documentation claire et exemples concrets

## 6. Technologies Utilisées

- **Flutter** 3.x : Framework multiplateforme
- **Dart** : Langage de programmation
- **animated_text_kit** : Animations de texte
- **image_picker** : Sélection d'images
- **Material Design** : Composants UI

## 7. Points Forts

✅ 4 concepts IA différents  
✅ Interface intuitive et colorée  
✅ Explications pédagogiques  
✅ Thème développement durable  
✅ Pas de dépendances ML lourdes  
✅ Fonctionne offline  

## 8. Améliorations Futures

- Intégration de vrais modèles TensorFlow Lite
- Historique des interactions
- Gamification (scores, badges)
- Mode multijoueur
- Plus de langues