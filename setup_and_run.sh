#!/bin/bash

echo "--- Installation des outils (Packer, Ansible, Dépendances) ---"
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" -y
# Correction de la clé Yarn (Troubleshooting)
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 62D54FD4003F6525
sudo apt-get update
sudo apt-get install packer ansible python3-kubernetes -y

echo "--- Création du cluster K3d ---"
# Supprime le cluster s'il existe déjà pour repartir sur du propre
k3d cluster delete lab || true 
k3d cluster create lab --servers 1 --agents 2

echo "--- Lancement de l'automatisation (Build & Deploy) ---"
make all

echo "--- Vérification finale ---"
kubectl get all
echo "Le déploiement est terminé. Vous pouvez maintenant lancer le port-forward."
