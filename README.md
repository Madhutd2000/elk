# Ansible-elk
This Ansible playbook installs and configure ELK stack.<br />

## Introduction
The **ELK** stack gives you the ability to aggregate logs from all your systems and applications, analyze these logs, and create visualizations for application and infrastructure monitoring, faster troubleshooting, security analytics. <br />
It stands for **Elasticsearch, Logstash and Kibana**.<br />
**Elasticsearch** is a search and analytics engine. <br />
**Logstash** is a server‑side data processing pipeline that ingests data from multiple sources simultaneously, transforms it, and then sends it to a "stash" like Elasticsearch.<br/>
**Kibana** lets users visualize data with charts and graphs in Elasticsearch. <br />


Ansible version being used is : **2.9.25**

## Versions being installed: 
1. Elastic search - 7.x <br />
2. Kibana - 7.x <br />
3. Logstash - 7.x<br />
      
## Prerequistie:

Make sure there is a ssh connectivity between ansible host to all servers specified in the inventory file. <br />
       **ansible all -m ping -u user-name -i hosts --private-key=path-to-pem-key** <br />
       **Eg: ansible elk -m ping -u ec2-user -i hosts --private-key=/etc/ansible/pems/elk-pem-us-east-1.pem** <br />
Remove **elastic-stack-ca.p12** and **elastic-certificates.p12** if already exists in /etc/ansible/ansible-elk/elk/ before running ansible command.
      
## Steps:
1. Update hosts in hosts file. 
2. Run ansible command. <br />
      **ansible-playbook -i elk/hosts elk/main.yml -u user --private-key=path-to-pem-key** <br />
      **Eg: ansible-playbook -i hosts main.yml -u ec2-user --private-key=/etc/ansible/pems/elk-pem-us-east-1.pem** 

       



