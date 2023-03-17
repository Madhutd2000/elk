pipeline {
  agent any
  tools {
      terraform "terraform"
  }
  options {
        ansiColor('xterm')
    }
      
  parameters
    {
   string(name: 'TF_VAR_access_key' ,defaultValue: 'ACCESSKEY')
   string(name: 'TF_VAR_secret_key' ,defaultValue: 'SECRETKEY')
   string(name: 'TF_VAR_aws_session_token' ,defaultValue: 'TOKEN')
    
    string(name: 'Bucket_name' ,description: 'Bucket name, to store tfstate files', defaultValue: 'bucket-name')
    string(name: 'Dynamodb_table_name' ,description: 'DynamoDB table name, for locking tfstate files', defaultValue: 'table-name')
      
    string(name: 'project_name' , defaultValue: 'Voltage')
    string(name: 'environment' , defaultValue: 'Nonprod')
    string(name: 'ami_id' ,defaultValue: 'ami-01d5ac8f5f8804300')
    string(name: 'region' ,defaultValue: 'us-east-2')  
   // string(name: 'TF_VAR_create_pemkey' ,defaultValue: 'YES' , description: 'type YES to create new pem key , NO to use existed pem key' )
//     choice(
//             choices: ['YES', 'NO'], 
//             name: 'create_pemkey' ,
//             description: 'select YES to create new pem key , NO to use existed pem key'
//                             )
    string(name: 'PemkeyName' ,defaultValue: 'testing_elk')  
   // file name:'upload pem key', description:'upload the existed pem key only if you select NO option in create_pemkey'
   // file name: 'upload pemkey' ,description: 'contains list of projects to be build')
   // string(name: 'sg_name' ,defaultValue: 'volt_elk_sg')   
    string(name: 'instance_type' ,defaultValue: 't2.xlarge') 
//     string(name: 'ES_instance_name' ,defaultValue: 'elk-elasticsearch')
//     string(name: 'instance_name' ,defaultValue: 'elk-logstash')
//     string(name: 'instance_name' ,defaultValue: 'elk-kibana')
      
    string(name: 'ES_Number_of_instances' ,defaultValue: '3')
    string(name: 'LS_Number_of_instances' ,defaultValue: '2')
    string(name: 'KI_Number_of_instances' ,defaultValue: '1')
      
    string(name: 'vpc_id' ,defaultValue: 'vpc-0802b1796e7acbeeb')  
    string(name: 'subnet_id1' ,defaultValue: 'subnet-01776c3a64107448f')
    string(name: 'subnet_id2' ,defaultValue: 'subnet-0c12169168e1f4286')
    string(name: 'subnet_id3' ,defaultValue: 'subnet-080647bd5a36a94df')   
  booleanParam(name: 'terraform_init', defaultValue: false, description: 'Select to Run terraform plan command')              
  booleanParam(name: 'terraform_plan', defaultValue: true, description: 'Select to Run terraform plan command')            
  booleanParam(name: 'terraform_apply', defaultValue: false, description: 'Select to Run terraform apply command')
  booleanParam(name: 'terraform_destroy', defaultValue: false, description: 'Select to Run terraform destroy command') 
      

    }

  stages {

    stage('Git Checkout') {
      steps {
        git branch: 'jenkins_pipeline', credentialsId: 'svc-usjenkins-devops', url: 'git@github.worldpay.com:Docet-USA/elk.git'
      }
    }
 stage('Copy Var') {
      steps{
            sh 'ls -lart'    
            sh "pwd"
            echo "cd terraform_script"
            dir('terraform_script') {
                  sh "pwd"
              //sh "echo ${create_pemkey}"
                  sh 'echo "access_key = \\"${TF_VAR_access_key}\\"" >> ./terraform.tfvars'
                  sh 'echo "secret_key = \\"${TF_VAR_secret_key}\\"" >> ./terraform.tfvars'
                  sh 'echo "aws_session_token = \\"${TF_VAR_aws_session_token}\\"" >> ./terraform.tfvars'
                  
                  sh 'echo "project_name = \\"${project_name}\\"" >> ./terraform.tfvars'
                  sh 'echo "ENV = \\"${environment}\\"" >> ./terraform.tfvars'
                  sh 'echo "ami_ID = \\"${ami_id}\\"" >> ./terraform.tfvars'
                  sh 'echo "region = \\"${region}\\"" >> ./terraform.tfvars'
                 
                  sh 'echo "PemkeyName = \\"${PemkeyName}\\"" >> ./terraform.tfvars' 
             //     sh 'echo "create_pemkey = \\"${create_pemkey}\\"" >> ./terraform.tfvars'
             //   sh 'echo "instance_name = \\"${instance_name}\\"" >> ./terraform.tfvars'
              
                  sh 'echo "ES_Number_of_instances = \\"${ES_Number_of_instances}\\"" >> ./terraform.tfvars'
                  sh 'echo "LS_Number_of_instances = \\"${LS_Number_of_instances}\\"" >> ./terraform.tfvars'
                  sh 'echo "KI_Number_of_instances = \\"${KI_Number_of_instances}\\"" >> ./terraform.tfvars'
              
                 sh 'echo "sg_name = \\"${project_name}_${environment}_elk_sg\\"" >> ./terraform.tfvars'
                  sh 'echo "ec2_instance_type = \\"${instance_type}\\"" >> ./terraform.tfvars'
                  sh 'echo "vpc_id = \\"${vpc_id}\\"" >> ./terraform.tfvars'
                  sh 'echo "subnet_ids = [\\"${subnet_id1}\\",\\"${subnet_id2}\\",\\"${subnet_id2}\\"]" >> ./terraform.tfvars'
                  

               
                  
                     
            }
           
            
     
}
   }
    stage('Terraform Init') {
      when{
       expression { params.terraform_init}
     }
      steps {
      ansiColor('xterm') {
         sh "pwd"
        dir('terraform_script') {
          sh "pwd"
          //sh label: '', script: 'terraform init'
          sh label: '', script: 'terraform init -reconfigure -backend-config="access_key=${TF_VAR_access_key}" -backend-config="secret_key=${TF_VAR_secret_key}" -backend-config="token=${TF_VAR_aws_session_token}" -backend-config "bucket=${Bucket_name}" -backend-config "dynamodb_table=${Dynamodb_table_name}" -backend-config "key=elk/terraform.tfstate" -backend-config "region=${region}"'
        }
        sh "pwd"
      }
      }
    }
    
    stage('Terraform Plan') {
      when{
       expression { params.terraform_plan}
     }
      steps {
      ansiColor('xterm') {
         sh "pwd"
        dir('terraform_script') {
          sh "pwd"
          sh label: '', script: 'terraform plan'
        }
        sh "pwd"
      }
      }
    }
   
    stage('Terraform apply') {
       when{
       expression { params.terraform_apply}
     }
      steps {
         ansiColor('xterm') {
         sh "pwd"
        dir('terraform_script') {
     sh label: '', script: 'terraform apply --auto-approve'
        }
        sh "pwd"
         }
      }
    }
    
    stage('waiting for instances to be in running state') {
       when{
       expression { params.terraform_apply}
     }
      steps {
         ansiColor('xterm') {
         sh "pwd"
        echo 'Waiting 1.5 minutes for instances to be in running state'
        sleep 90
       
         }
      }
    }
    
    
    stage('Terraform destroy') {
       when{
       expression { params.terraform_destroy}
     }
      steps {
         ansiColor('xterm') {
         sh "pwd"
        dir('terraform_script') {
     sh label: '', script: 'terraform destroy --auto-approve'
        }
        sh "pwd"
         }
      }
    }
    
    
   stage('ansible playbook')
    {
      when{
       expression { params.terraform_apply}
     }
      steps {
        sh "pwd"
      sh 'cd ansible_script'
    dir('ansible_script') {
      sh "pwd"
      //sh 'chmod 400 ../../pem-keys/*.pem'
      sh 'chmod 400 ../"${PemkeyName}".pem'
      sh 'ansible-playbook  -i hosts.ini main.yml'   
    }
    sh "pwd"
        
     
     
      }
    }
   
    
  }
}
