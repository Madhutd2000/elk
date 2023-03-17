terraform {
  required_version = ">= 1.0.11"
}

resource "aws_instance" "ES" {

  count = var.ES_Number_of_instances     
  ami = var.ami_ID
  instance_type = var.ec2_instance_type
  
  subnet_id =  element(var.subnet_ids , count.index)
  vpc_security_group_ids = [module.security_group[0].id]
  key_name = var.PemkeyName
  
  tags = {
    Name = "${var.project_name}_${var.ENV}_elastic_search_${count.index+1}"
    Environment = "${var.ENV}"
         }
  depends_on = [module.security_group,
                  local_file.ssh_key   
               ]

}




resource "aws_instance" "LS" {

  count = var.LS_Number_of_instances     
  ami = var.ami_ID
  instance_type = var.ec2_instance_type
  
  subnet_id =  element(var.subnet_ids , count.index)
  vpc_security_group_ids = [module.security_group[0].id]
  key_name = var.PemkeyName
  
  tags = {
    Name = "${var.project_name}_${var.ENV}_logstash_${count.index+1}"
    Environment = "${var.ENV}"
         }
  depends_on = [module.security_group,
                local_file.ssh_key]
}


resource "aws_instance" "KI" {

  count = var.KI_Number_of_instances     
  ami = var.ami_ID
  instance_type = var.ec2_instance_type
  
  subnet_id =  element(var.subnet_ids , count.index)
  vpc_security_group_ids = [module.security_group[0].id]
  key_name = var.PemkeyName
  
  tags = {
    Name = "${var.project_name}_${var.ENV}_kibana"
    Environment = "${var.ENV}"
         }

  depends_on = [module.security_group,
                local_file.ssh_key]

}


