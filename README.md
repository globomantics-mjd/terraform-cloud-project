# Deploying with infra to AWS using VCS with Terraform Cloud

Let's talk about the various options for deployment with Terraform Cloud. The infra code with app code are in source control at the moment, so we are going to deploy it using the github version control. We'll change that momentarily.

## Demos

- Creating 3 workspaces for dev, stage and prod on TFC.
- Configuring variable values and environment variables
- Updating the Terraform configuration
- Deploying the configuration using git branching.

### Creating a workspace on TFC with the CLI workflow

Workspaces can be created using the UI, CLI, or API. To create a new workspace for the configuration, simply update the `cloud` block in the `backend.tf` file with your organization name. Save the file and run `terraform init`.

`backend.tf`

```hcl
terraform {
  cloud {
    organization = <TFC Organization>

    workspaces {
      name = "diamond_dogs_Development"
      name = "diamond_dogs_staging"
      name = "diamond_dogs_Production"

    }
  }
}
```
### Configuring variable values and environment variables

Terraform uses all Terraform and Environment variables for all plans and applies in this workspace. Workspaces using Terraform 0.10.0 or later can also load default values from any \*.auto.tfvars files in the configuration. You may want to use the Terraform Cloud Provider or the variables API to add multiple variables at once.

Rename `terraform.tfvars` to `terraform.auto.tfvars`

Terraform requires credentials in order to communicate with your cloud provider's API. These API keys should never be stored directly in your terraform code. We will use Terraform Cloud environment variables to store our sensitive cloud credentials for AWS.

- In the `Variables` tab of your workspace you can add environment variables for the AWS Credentials
- Add a Environment variable named `AWS_ACCESS_KEY_ID` with your AWS Access Key
- Add a second Environment variable named `AWS_SECRET_ACCESS_KEY` with your AWS Secret Key. Be sure to mark this variable as sensitive. Sensitive variables will not be displayed within the environment, and can only be overwritten - not read.
- For our case as Dev, stage and prod workspaces share environmental variables it is best to use VariableSet.

## Commands to connect locally with Terraform Cloud

```bash
terraform login
```
```bash
terraform init
```
```bash
terraform plan
```
```bash
terraform apply
```
```bash
terraform destroy
```
