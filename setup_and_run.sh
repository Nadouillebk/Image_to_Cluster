#!/bin/bash

echo "--- 🧹 Nettoyage initial ---"
k3d cluster delete lab || true
sleep 5

echo "--- Création du cluster avec mapping permanent ---"
# Cette ligne crée la redirection indestructible entre 8081 et 30081
k3d cluster create lab --servers 1 --agents 2 -p "8081:30081@agent:0"

echo "--- Lancement de l'automatisation (Build & Deploy) ---"
make all

echo "--------------------------------------------------------"
echo "✅ TOUT EST PRÊT ET AUTOMATISÉ !"
echo "1. Allez dans l'onglet 'PORTS' et vérifiez que le 8081 est Public."
echo "2. Pour tout changement futur (sol rose, etc.), tapez juste : make all"
echo "--------------------------------------------------------"
