
# Terraform-Script-To-Launch-EC2-Instances
This Terraform script launches required number of EC2 Instances for ELK stack in specified subnets by using specified pemkey and security group.

### Prerequisite:

1. Install Terraform of version  v1.0.11 or above
2. git should be installed

# Instruction to run terraform.

1. Clone this repository (branch Terraform_ELK)
2. Run the command $cd Terraform-Script-To-Launch-EC2-Instances
3. Run the command $terraform init 
4. **Update variables in terraform.tfvars** </br>
      variables need to change   </br>
       - project_name           </br>
       - ami_ID                  </br>
       - ec2_instance_type        </br>
       - region                    </br>
       - access_key                  </br>
       - secret_key                   </br>
       - aws_session_token             </br>
       - ES_instance_name               </br>
       - LS_instance_name               </br>
       - KI_instance_name               </br>
       - vpc_id                          </br>
       - subnet_ids                     </br>
       - security_group_id                 </br>
       
6. Run the command $terraform plan 
7.  Run the command $terraform apply

To destory: terraform destroy
