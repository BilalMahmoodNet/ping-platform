# Makefile — Ping Platform Terraform shortcuts
# Usage: make <target>

ENV ?= dev

init:
	terraform init

# ── Dev ───────────────────────────────────────────────────────
plan-dev:
	terraform plan -var-file=environments/dev/dev.tfvars

apply-dev:
	terraform apply -var-file=environments/dev/dev.tfvars -auto-approve

destroy-dev:
	terraform destroy -var-file=environments/dev/dev.tfvars -auto-approve

# ── Stage (uncomment namespaces module first) ─────────────────
plan-stage:
	terraform plan -var-file=environments/stage/stage.tfvars

apply-stage:
	terraform apply -var-file=environments/stage/stage.tfvars -auto-approve

destroy-stage:
	terraform destroy -var-file=environments/stage/stage.tfvars -auto-approve

# ── Quick cost-saving commands ────────────────────────────────
stop:
	az aks stop --resource-group ping-lab-rg --name ping-lab-aks

start:
	az aks start --resource-group ping-lab-rg --name ping-lab-aks
	az aks get-credentials --resource-group ping-lab-rg --name ping-lab-aks --overwrite-existing

# Nuclear option — destroys everything, $0 cost
nuke:
	terraform destroy -var-file=environments/dev/dev.tfvars -auto-approve

# Rebuild from scratch after nuke
rebuild:
	terraform apply -var-file=environments/dev/dev.tfvars -auto-approve
	az aks get-credentials --resource-group ping-lab-rg --name ping-lab-aks --overwrite-existing

status:
	kubectl get nodes -o wide
	kubectl get pods -A --field-selector=metadata.namespace!=kube-system

.PHONY: init plan-dev apply-dev destroy-dev plan-stage apply-stage destroy-stage stop start nuke rebuild status