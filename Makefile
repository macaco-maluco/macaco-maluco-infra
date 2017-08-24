plan:
	terraform get
	terraform plan

apply:
	terraform get
	terraform apply

show:
	terraform get
	terraform show

.DEFAULT_GOAL := show
