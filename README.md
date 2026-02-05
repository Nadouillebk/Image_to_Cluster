------------------------------------------------------------------------------------------------------
Introduction
------------------------------------------------------------------------------------------------------
L’objectif est de comprendre comment des outils d’Infrastructure as Code permettent de passer d’un artefact applicatif maîtrisé à un déploiement cohérent et automatisé sur une plateforme d’exécution.
  
-------------------------------------------------------------------------------------------------------
Architecture Cible
-------------------------------------------------------------------------------------------------------
L'architecture repose sur un cluster K3d composé de :
1 - Noeud Master (Control-plane).
2 - Noeud Workers (Agents).

On va donc mettre en place :
Packer : pour la création d'une image Docker basée sur Nginx incluant directement notre index.html.
Ansible : pour l'orchestration du déploiement des ressources sur Kubernetes.
K3d : pour simuler un environnement Kubernetes multi-noeuds léger dans GitHub Codespaces.
Makefile : pour automatiser l'intégralité du workflow.

-------------------------------------------------------------------------------------------------------
Guide d'utilisation
-------------------------------------------------------------------------------------------------------
Grâce au Makefile, l'intégralité du processus est automatisé.

1. Pré-requis
Les outils (Packer, Ansible, K3d) doivent être installés dans l'environnement.

2. Déploiement complet
Exécutez la commande suivante pour construire l'image, l'importer et la déployer :
>make all

3. Vérification
On vérifie que les ressources sont bien déployées :
>kubectl get all

4. Accès à l'application
Pour visualiser le rendu final :

On lance le port-forward : 
>kubectl port-forward svc/my-nginx-service 8081:80.
On ouvre ensuite le port 8081 dans l'onglet de Codespaces.
Cela nos permet d'obtenir notre page index.html.

-------------------------------------------------------------------------------------------------------
Troubleshooting
-------------------------------------------------------------------------------------------------------
Pendant cet atelier, j'ai rencontré et résolu les défis techniques suivants :

- Conflit de clés GPG (Yarn) : le dépôt Yarn bloquait les mises à jour système apt.
- Solution : Importation manuelle de la clé publique 62D54FD4003F6525.

- Bibliothèque Python Kubernetes : Ansible ne pouvait pas communiquer avec l'API Kubernetes.
- Solution : Installation du paquet système python3-kubernetes pour contourner les restrictions des environnements gérés (PEP 668).

- Namespace manquant : Erreur lors du déploiement du service via Ansible.
- Solution : Définition explicite du namespace: default dans le playbook deploy.yml.
