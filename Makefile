CLUSTER_NAME=lab
IMAGE_NAME=my-custom-nginx:latest

all: build import deploy

build:
	@echo "--- Construction de l'image avec Packer ---"
	packer init build.pkr.hcl
	packer build build.pkr.hcl

import:
	@echo "--- Import de l'image dans K3d ---"
	k3d image import $(IMAGE_NAME) -c $(CLUSTER_NAME)

deploy:
	@echo "--- Déploiement avec Ansible ---"
	ansible-playbook deploy.yml

clean:
	@echo "--- Nettoyage ---"
	kubectl delete deployment my-nginx-web || true
	kubectl delete service my-nginx-service || true
