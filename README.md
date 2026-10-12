# Exercice — Maintenance et versionnement d'un script d'administration Linux

**Durée :** 30 minutes  
**Organisation :** Individuel  
**Public :** Systèmes et Réseaux

## Objectifs

Vous êtes chargé de préparer un script d'administration destiné à contrôler rapidement l'état d'un serveur Linux.

Vous devrez identifier et corriger un dysfonctionnement, valider le comportement du script, publier une première version sur GitHub, puis expérimenter différentes méthodes de correction de l'historique Git.

**Prérequis :** Linux avec Bash et Git, identité Git configurée, accès GitHub fonctionnel, éditeur de texte au choix.

**Livrables :** URL du dépôt GitHub et fichier de réponses contenant les observations et le tableau de bilan. Le fichier de réponses doit rester en dehors du dépôt.

## 1. Préparer, tester et publier le script — 17 min

### Préparation de l'environnement

Créez un répertoire nommé `atelier-git` et initialisez-y un dépôt Git avec une branche principale `main`.

Créez deux fichiers :
- `controle.sh` : script Bash de contrôle du serveur.
- `configuration.conf` : fichier contenant les paramètres du contrôle.

Le fichier `configuration.conf` doit contenir :

```bash
SERVEUR="Serveur-Production"
SEUIL_DISQUE=80
SEUIL_MEMOIRE=85
```

Le fichier `controle.sh` doit contenir :

```bash
#!/bin/bash

source ./config.cfg

echo "================================"
echo " Contrôle du serveur : $SERVEUR"
echo "================================"

echo ""
echo "Espace disque :"
df -h /

echo ""
echo "Mémoire :"
free -h

echo ""
echo "Durée de fonctionnement :"
uptime -p

echo ""
echo "Seuil disque configuré : $SEUIL_DISQUE %"
echo "Seuil mémoire configuré : $SEUIL_MEMOIRE %"
```

### Premier test

Rendez le script exécutable et lancez-le depuis son répertoire de travail.

Identifiez le dysfonctionnement empêchant le chargement correct de la configuration. Consignez l'erreur observée.

### Correction et validation

Corrigez uniquement le problème identifié, sans modifier le nom du fichier de configuration.

Vérifiez que :
- Le nom du serveur apparaît correctement.
- Les informations du disque, de la mémoire et de la durée de fonctionnement sont affichées.
- Les deux seuils sont correctement récupérés.

Consignez la cause du problème, la correction et le résultat du test.

### Publication initiale

Enregistrez une première version fonctionnelle dans Git avec un message de commit approprié.

Créez un dépôt GitHub vide nommé `atelier-git`, associez-le au dépôt local et publiez la branche principale.

Vérifiez la présence des deux fichiers sur GitHub et la correction du script.

**Important :** ne publiez plus aucune modification avant l'étape 7. Les opérations suivantes doivent rester locales.

## 2. Retirer une modification de la préparation du commit — 4 min

Ajoutez dans `configuration.conf` :

```bash
MODE_MAINTENANCE=false
```

Préparez cette modification pour un prochain commit et vérifiez son état.

Retirez ensuite la modification de la zone de préparation, tout en conservant son contenu dans le fichier.

Vérifiez l'état du dépôt et le contenu du fichier.

**À observer :** la modification est-elle toujours présente ? Est-elle encore préparée pour un commit ?

Ne créez pas de commit à cette étape.

## 3. Annuler un commit en conservant les modifications préparées — 5 min

Enregistrez la modification précédente dans un commit intitulé `Ajouter le mode maintenance`.

Annulez ce dernier commit en conservant toutes ses modifications dans la zone de préparation.

Vérifiez l'état du dépôt et le contenu du fichier.

Sans préparer à nouveau les fichiers, recréez un commit intitulé `Configurer le mode maintenance du serveur`.

**À observer :** pourquoi est-il possible de créer immédiatement un nouveau commit ?

## 4. Annuler un commit en conservant les modifications non préparées — 5 min

Annulez le dernier commit, en conservant les modifications dans les fichiers de travail, mais pas dans la zone de préparation.

Vérifiez le fichier de configuration et l'état du dépôt.

Essayez de créer un commit intitulé `Activer la configuration de maintenance` sans autre opération préalable.

Consignez le résultat, puis effectuez les opérations nécessaires pour enregistrer réellement ce commit.

**À observer :** quelle différence constatez-vous avec l'étape précédente ?

## 5. Abandonner un essai de configuration — 5 min

Dans `configuration.conf`, remplacez :

```bash
SEUIL_DISQUE=80
```

par :

```bash
SEUIL_DISQUE=95
```

Enregistrez cette modification dans un commit intitulé `Tester un seuil disque a 95 pourcent`.

Ajoutez ensuite, sans créer de nouveau commit :

```bash
PARAMETRE_TEMPORAIRE="A_SUPPRIMER"
```

Vous décidez d'abandonner complètement cet essai.

Revenez à l'état du dépôt précédant le dernier commit, en supprimant également les modifications non enregistrées des fichiers suivis.

Vérifiez le contenu de `configuration.conf` et l'état du dépôt.

**À observer :** quelles modifications ont disparu ? Les paramètres précédents ont-ils été conservés ?

**Attention :** cette opération est potentiellement destructive. Travaillez exclusivement dans le dépôt de l'exercice.

## 6. Vérifier le résultat local — 4 min

Votre fichier `configuration.conf` doit contenir exactement :

```bash
SERVEUR="Serveur-Production"
SEUIL_DISQUE=80
SEUIL_MEMOIRE=85
MODE_MAINTENANCE=false
```

Vérifiez que le dépôt local est propre.

Exécutez à nouveau `controle.sh` et assurez-vous que son fonctionnement n'a pas été altéré.

Consultez ensuite le dépôt GitHub et comparez les versions locale et distante.

**Question :** pourquoi le paramètre de maintenance est-il présent localement, mais pas encore sur GitHub ?

## 7. Publier et analyser les manipulations — 5 min

Publiez la version finale sur GitHub.

Vérifiez la présence des deux fichiers, le bon fonctionnement du script et les quatre paramètres de configuration.

Complétez le tableau :

| Manipulation | Contenu du fichier conservé ? | Modifications préparées ? |
|---|---|---|
| `restore --staged` | Oui|Non |
| `reset --soft` |Oui |Oui |
| `reset --mixed` |Oui |Oui |
| `reset --hard` |Non |Oui |

Répondez aux questions :

1. Quelle différence existe entre une modification présente dans le répertoire de travail et une modification préparée pour un commit ?
Modif préparée = zone de transit (commit). Pas encore envoyé en remote mais disctinct du répertoire de travail local

2. Pourquoi était-il possible de recréer immédiatement un commit à l'étape 3, mais pas à l'étape 4 ?
Car il faut refaire "add ." à l'étape 4, et non à l'étape 3.

3. Qu'est-il arrivé au paramètre temporaire lors de l'annulation de l'étape 5 ?
Supprimé

4. Pourquoi la modification de configuration n'était-elle pas visible sur GitHub avant la dernière publication ?
Car on a pas effectué de push vers l'origine distante

5. Quel risque présente une annulation destructive dans un environnement d'administration système ?
Un point de non retour. L'acte est irréversible.

## Critères de réussite

- Le script Bash a été corrigé et testé avant son premier commit.
- Les deux fichiers ont été publiés correctement.
- Les modifications locales ont été conservées ou supprimées conformément aux consignes.
- Le dépôt final est propre.
- Les différences entre les mécanismes d'annulation sont correctement expliquées.