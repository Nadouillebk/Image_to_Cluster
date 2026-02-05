# Projet : De l'Image au Cluster (Workflow IaC)

------------------------------------------------------------------------------------------------------
Introduction
------------------------------------------------------------------------------------------------------
Ce projet démontre l'automatisation complète du cycle de vie d'une app web personnalisée sur Kubernetes. L'objectif est de passer d'un fichier index.html à une infrastructure résiliente et accessible, en utilisant les principes de IaC.
  
-------------------------------------------------------------------------------------------------------
Architecture Cible
-------------------------------------------------------------------------------------------------------
L'architecture repose sur un cluster K3d composé de :
- Noeud Master (Control-plane).
- Noeud Workers (Agents).

On va donc mettre en place :
- Packer : création d'une image Docker contenant index.html.
- Ansible : orchestration du déploiement (Deployment & Service NodePort).
- Makefile : automatisation des tâches répétitives (Build, Import, Deploy).
- K3d : pilotage du cluster avec mapping de port permanent pour un accès direct.

-------------------------------------------------------------------------------------------------------
Guide d'utilisation
-------------------------------------------------------------------------------------------------------
Pour faciliter l'évaluation, j'ai créé un script d'automatisation totale. Une seule commande suffit pour tout installer et déployer.
1. Déploiement Initial
Exécutez le script suivant à la racine du projet :
> ./setup_and_run.sh

Ce script s'occupe de :
1. Supprimer tout ancien cluster pour garantir un environnement propre.
2. Créer le cluster avec un mapping de port permanent (8081 -> 30081).
3. Lancer le make all (Packer Build -> K3d Import -> Ansible Deploy).

Accès à l'application
Grâce au mapping réseau natif de K3d, l'application est immédiatement accessible sans commande supplémentaire :
1. Allez dans l'onglet PORTS de Codespaces.
2. Ouvrez l'URL associée au port 8081.

-------------------------------------------------------------------------------------------------------
Développement Continu
-------------------------------------------------------------------------------------------------------
Si vous modifiez le contenu du fichier index.html (changement de couleur du sol, texte), il n'est pas nécessaire de relancer le script initial. Utilisez simplement :
>make all

Le Makefile reconstruira l'image, l'importera et forcera un rollout restart du déploiement pour appliquer les changements instantanément sans couper l'accès réseau.

-------------------------------------------------------------------------------------------------------
Troubleshooting
-------------------------------------------------------------------------------------------------------
Pendant cet atelier, j'ai rencontré et résolu les défis techniques suivants :

- Conflit de clés GPG (Yarn) : Correction de l'erreur apt update par l'importation manuelle de la clé publique 62D54FD4003F6525.
- Bibliothèque Python Kubernetes : Installation du paquet système python3-kubernetes pour permettre à Ansible d'interagir avec l'API Kubernetes.
- Namespace manquant : Erreur de déploiement Ansible résolue par la définition explicite du namespace: default.
- Mapping Réseau : Remplacement du port-forward manuel par un mapping permanent au niveau du cluster (-p 8081:30081@agent:0) pour garantir la persistance de l'accès lors des mises à jour.
