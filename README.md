# ELK stack
This Jenkins pipeline creates ec2 instances  and configure ELK stack.<br />

## Introduction
The **ELK** stack gives you the ability to aggregate logs from all your systems and applications, analyze these logs, and create visualizations for application and infrastructure monitoring, faster troubleshooting, security analytics. <br />
It stands for **Elasticsearch, Logstash and Kibana**.<br />
**Elasticsearch** is a search and analytics engine. <br />
**Logstash** is a server‑side data processing pipeline that ingests data from multiple sources simultaneously, transforms it, and then sends it to a "stash" like Elasticsearch.<br/>
**Kibana** lets users visualize data with charts and graphs in Elasticsearch. <br />

This jenkins job will: </br>
1. Create a security group.
2. Creates a new pem key.
3. Creates 6 EC2 instances - 3 Elasticsearch, 2 logstash and 1 kibana servers.
4. Configures ELK by running ansible playbook.
      
## Prerequistie:
1. AMI of centos 8
2. VPC id
3. Subnet ids

      
## Steps:
1. Create a jenkins job and pass values to below parameters.
      - TF_VAR_access_key </br>
      - TF_VAR_secret_key </br>
      - TF_VAR_aws_session_token </br>
      - project_name </br> 
      - environment </br>
      - ami_id </br>
      - region </br>
      - PemkeyName  </br>
      - sg_name </br>
      - instance_type </br>
      - vpc_id </br>
      - subnet_id1 </br>
      - subnet_id2 </br>
      - subnet_id3 </br>
      - TF_VAR_access_key </br>
      - TF_VAR_access_key </br>
           
2. Select beow options accordingly
      - terraform_init          </br>    
      - terraform_plan          </br>
      - terraform_apply         </br>
      - terraform_destroy       </br>

      
      


