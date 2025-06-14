# 🎾 Modélisation d’un Match de Tennis par Chaînes de Markov

Projet académique visant à modéliser les différentes composantes d’un match de tennis (jeu, set, match) à l’aide de chaînes de Markov, et à analyser leur effet amplificateur sur les écarts de niveau entre deux joueurs.

---

## 📁 Structure du projet

- `rapport/`  
  Contient le rapport complet du projet (PDF, 25 pages).

- `Codes/`  
  Dossier principal contenant tous les scripts MATLAB, organisés par thème :

  - `Jeu/`  
    Modélisation détaillée d’un jeu :
    - `probabiliteEtDeriveJeu.m`
    - `probaDeFaire4040.m`
    - `ProbaGagnerJeuAPartirDe4040EtDerive.m`

  - `Set/`  
    Modélisation d’un set :
    - `ProbabilitéDeFaire55Set.m`
    - `SimulationDePlusieursSets.m`

  - `Match/`  
    Modélisation d’un match :
    - `ProbabilitéDeFaire22Match.m`

  - `ComparaisonEntreJeuSetMatch/`  
    Comparaisons globales entre les trois niveaux :
    - `ComparaisonDureeDeVieJeuSetMatch.m`
    - `ComparaisonProbaVictoireEtDeriveJeuSetMatch.m`

  - `ComparaisonAvecRealite/`  
    Comparaison des prédictions avec les données réelles ATP :
    - `ComparaisonRealiteJeu.m`
    - `ComparaisonRealiteSet.m`
    - `ComparaisonRealiteMatch.m`

---

## 💻 Technologies utilisées

- **MATLAB**
- Modélisation par chaînes de Markov
- Simulations et visualisations de résultats

---

## 📘 Rapport

Le rapport (PDF) contient :
- Modélisations mathématiques des états (jeu, set, match)
- Calculs matriciels (absorption, durée de vie)
- Simulations (probabilités, scores finaux)
- Comparaison avec données réelles (Nadal, Simon, Moutet)

---

## 📄 Licence

Usage académique uniquement.  
Données issues de [Tennis Abstract](https://www.tennisabstract.com/).
