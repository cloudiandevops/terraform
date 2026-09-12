### Terraform State Management 

Terraform state keeps track of the infrastructure Terraform manages and maps your configuration to real-world resources.

terraform state list	--> List all resources in the state
terraform state show <resource>	--> Show details of a resource in state
terraform state pull		--> Download/read the current state
terraform state push <file>	 --> Push a state file
terraform state rm <resource>	--> 	Remove a resource from state
terraform state mv <old> <new> --> Rename/move a resource in state
terraform state replace-provider	--> Replace a provider in state
terraform refresh	Refresh state 	--> from real infrastructure (legacy; use plan/apply refresh behavior)

### Terraform validation 

terraform fmt -->	Is my code formatted correctly?
terraform validate --> Is my Terraform configuration valid?

terraform fmt
      ↓
Fixes formatting

terraform validate
      ↓
Checks whether Terraform configuration is valid


### Terraform drift

Terraform drift is a situation where the real infrastructure differs from the infrastructure defined in Terraform configuration, 
usually because someone or something changed the infrastructure outside Terraform.

Terraform drift is fixed by running terraform plan to detect the difference, then either applying Terraform's desired configuration
or updating the Terraform configuration to reflect an intentional infrastructure change.

### Terraform taint / replace

terraform taint was used to tell Terraform: "This resource should be recreated the next time I run terraform apply."

# terraform apply -replace="aws_instance.web" 

Resource has a problem
        ↓
Tell Terraform to replace it
        ↓
terraform apply -replace="aws_instance.web"
        ↓
Destroy old resource
        ↓
Create new resource

Terraform taint was used to mark a resource as needing replacement on the next apply. It is deprecated in modern Terraform; -replace should be used instead.

### Terraform import

terraform import = bring an existing real-world resource into Terraform management/state.

The format is: terraform import <terraform_resource_address> <real_resource_id>

# terraform import aws_instance.web i-0123456789abcdef0

