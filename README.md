# Macaco Maluco infrastructure

[Terraform](https://www.terraform.io/) provisioning scripts to setup the Macaco Maluco infrastructure.

## Update the infrastructure

Before you run any commands, make sure to have all the dependencies installed:

```bash
make install
```

And a [values](https://www.terraform.io/docs/configuration/variables.html) file named `terraform.tfvars` with the Digital Ocean API key and the The movie database API key:

```bash
do_token = "value"
tmdb_api_key = "value"
```

On making any changes, first check the plan to make sure everything is correct:

```bash
make plan
```

If everything is OK, you can apply the changes:

```bash
make apply
```
