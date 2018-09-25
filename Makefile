# Self-Documented Makefile https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html

regions := fra1 tor1
environments := staging production
operations := dns lb nodes
ndef = $(if $(value $(1)),,$(error $(1) argument not set))
nreg = $(if $(filter $(1),$(regions)),,$(error $(1) not supported region))
nenv = $(if $(filter $(1),$(environments)),,$(error $(1) not supported environment))
nop = $(if $(filter $(1),$(operations)),,$(error $(1) not supported operation))

default: help

.PHONY: help
help:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: local-setup
local-setup: ## prints setup steps for running Terraform scripts
	@echo "1. Download and copy to /usr/local/bin the Terraform binary."
	@echo "2. Export TF_VAR_digitalocean_token environement variable, that contains the Terraform Digital Ocean token."
	@echo "3. Run \"terraform init\" command to initialize the working directory."

.PHONY: validate
validate: ## validates configurations for environment and DO region (dc=fra1 env=staging op=dns)
	$(call ndef,dc)
	$(call ndef,env)
	$(call ndef,op)
	$(call nreg,${dc})
	$(call nenv,${env})
	$(call nop,${op})
	@terraform validate -var-file=dc/${dc}/${env}/terraform.tfvars ${op}

.PHONY: debug
debug: ## generates plan based on environment and DO region (dc=fra1 env=staging op=dns)
	$(call ndef,dc)
	$(call ndef,env)
	$(call ndef,op)
	$(call nreg,${dc})
	$(call nenv,${env})
	$(call nop,${op})
	@terraform plan -var-file=dc/${dc}/${env}/terraform.tfvars -state=${op}.tfstate ${op}

.PHONY: deploy
deploy: ## setups data center based on environment and DO region (dc=fra1 env=staging op=dns)
	$(call ndef,dc)
	$(call ndef,env)
	$(call ndef,op)
	$(call nreg,${dc})
	$(call nenv,${env})
	$(call nop,${op})
	@terraform apply -var-file=dc/${dc}/${env}/terraform.tfvars -state=${op}.tfstate ${op}

.PHONY: destroy
destroy: ## destroys data center based on environment and DO region (dc=fra1 env=staging op=dns)
	$(call ndef,dc)
	$(call ndef,env)
	$(call ndef,op)
	$(call nreg,${dc})
	$(call nenv,${env})
	$(call nop,${op})
	@terraform destroy -var-file=dc/${dc}/${env}/terraform.tfvars -state=${op}.tfstate ${op}