variable "access_key" {    
  type = string
}

# variable "create_pemkey"{
# type = string
# }
variable "secret_key" {    
  type = string
}
variable "aws_session_token" {
  description = "Temporary session token used to create instances"
  type = string
}


# Creating a Variable for ami
variable "ami_ID" {       
  type = string
  # default = "ami-001089eb624938d9f"  # By default It selects Amazon Linux 2 AMI
}
                                           # Creating a Variable for instance_type
variable "ec2_instance_type" {    
  type = string
  # default = "t2.micro"
}

variable "region" {    
  type = string
  # default = "us-east-2"
}

variable "ES_Number_of_instances" { 
  description = "Number of EC2 instances to deploy"
  type        = number    
}

variable "LS_Number_of_instances" { 
  description = "Number of EC2 instances to deploy"
  type        = number    
}

variable "KI_Number_of_instances" { 
  description = "Number of EC2 instances to deploy"
  type        = number   
}


variable "subnet_ids" {
  type = list(string)
  
}

variable "PemkeyName" {
  type = string
  }


variable "vpc_id" {
  type = string
}
 
variable "sg_name" {
  type = string 

}

variable "project_name"{
  type = string
}

variable "ENV"{
  type = string
}



variable security_groups {
  default = [{
    description = "cassandra security_group"
    #name = "sg"
    ingress_rules = [{
						from = 5601  #from is of type number
						to = 5601  #to is of type number
						protocol = "tcp"
						cidr = ["10.0.0.0/8"]
            },
	    	    {
						from = 22  #from is of type number
						to = 22  #to is of type number
						protocol = "tcp"
						cidr = ["10.0.0.0/8"]
            },
            {
						from = 9300  #from is of type number
						to = 9300 #to is of type number
						protocol = "tcp"
						cidr = ["10.0.0.0/8"] 
            },
            {
						from = 9200  #from is of type number
						to = 9200 #to is of type number
						protocol = "tcp"
						cidr = ["10.0.0.0/8"] 
            },
            {
						from = 5044  #from is of type number
						to = 5044 #to is of type number
						protocol = "tcp"
						cidr = ["10.0.0.0/8"] 
            }
       ]
    egress_rules = [{
						from = 0  #from is of type number
						to = 0  #to is of type number
						protocol = "-1"
						 cidr = ["0.0.0.0/0"]
                  }]
  }]
}

variable user {
default = "centos"
}
