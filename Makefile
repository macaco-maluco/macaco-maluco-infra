ifeq ($(shell uname),Darwin)
	CT_RELEASE="apple-darwin"
	TERRAFORM_RELEASE="darwin"
else
	CT_RELEASE="unknown-linux-gnu"
	TERRAFORM_RELEASE="linux"
endif

install:
	curl -o terraform.zip https://releases.hashicorp.com/terraform/0.10.7/terraform_0.10.7_$(TERRAFORM_RELEASE)_amd64.zip
	unzip -o terraform.zip
	rm terraform.zip
	chmod +x terraform

	./terraform init

plan:
	./terraform get
	./terraform plan

apply:
	./terraform get
	./terraform apply

show:
	./terraform get
	./terraform show

destroy:
	./terraform destroy

.DEFAULT_GOAL := show
