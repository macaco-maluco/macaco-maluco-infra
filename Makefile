install:
	curl -o ct -L https://github.com/coreos/container-linux-config-transpiler/releases/download/v0.5.0/ct-v0.5.0-x86_64-apple-darwin
	chmod +x ct

	brew install terraform
	terraform init

compile:
	./ct --platform=digitalocean -in-file=config.yml -out-file=config.ign

plan: compile
	terraform get
	terraform plan

apply: compile
	terraform get
	terraform apply

show:
	terraform get
	terraform show

.DEFAULT_GOAL := show
