install:
	curl -o ct -L https://github.com/coreos/container-linux-config-transpiler/releases/download/v0.5.0/ct-v0.5.0-x86_64-apple-darwin
	chmod +x ct

	curl -L https://releases.hashicorp.com/terraform/0.10.7/terraform_0.10.7_darwin_amd64.zip | tar zxf -
	chmod +x terraform

	./terraform init

compile:
	./ct --platform=digitalocean -in-file=config.yml -out-file=config.ign

plan: compile
	./terraform get
	./terraform plan

apply: compile
	./terraform get
	./terraform apply

show:
	./terraform get
	./terraform show

.DEFAULT_GOAL := show
