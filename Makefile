plan:
	terraform plan -var-file=variables-values.tfvars

apply:
	terraform apply -var-file=variables-values.tfvars

show:
	terraform show -var-file=variables-values.tfvars

.DEFAULT_GOAL := show
