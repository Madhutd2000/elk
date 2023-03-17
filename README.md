Steps to set up ELK-Stack

Introduction: 

The ELK Stack is a great open-source stack for log aggregation and analytics. It stands for Elasticsearch (a NoSQL database and search server), Logstash (a log shipping and parsing service), and Kibana (a web interface that connects users with the Elasticsearch database and enables visualization and search options for system operation users).

This document has steps for setting up ElasticSearch, Logstash and Kibana In AWS platform.

Prerequisite:

OS: CentOS servers.

Hardware: 

      instance type: t3.2xlarge

Launch 3 Instances for Elastic Search in three different Availability Zone
Launch 2  Instances for Log Stash in two different Availability Zone
Launch 1  Instance for Kibana
Add below ports in the existing security group: 
Inbound Rules:

IP version

Type

Protocol

Port range

Source

IPv4

Custom TCP

TCP

5601

10.0.0.0/8

IPv4

Custom TCP

TCP

9300

10.0.0.0/8

IPv4

Custom TCP

TCP

9200

10.0.0.0/8

IPv4

Custom TCP

TCP

5044

10.0.0.0/8

IPv4

SSH

TCP

22

10.0.0.0/8

Outbound Rules:

IP version

Type

Protocol

Port range

Source

IPv4

All traffic

All

All

0.0.0.0/0



Note: Please follow the naming convention to the server name as “componentname-appname-nodeno”.

Note:

If your EC2 instances are of CENTOS 8 version, you might have trouble in installing any packages using yum or dnf command.

If you see below error, then run below 3 commands to resolve it



 cd /etc/yum.repos.d/
 sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
 sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*


Step:- 1 Install package for Elasticsearch

Setup three nodes Elasticsearch cluster:

Login to each Elasticsearch server and follow below steps:

Set the hostname.
           # hostnamectl set-hostname "Server-Name"

       2. Create a file elastic.repo file under /etc/yum.repos.d/ folder with the following content.

            # vi /etc/yum.repos.d/elastic.repo

            [elasticsearch-7.x]

            name=Elasticsearch repository for 7.x packages

            baseurl=https://artifacts.elastic.co/packages/7.x/yum

            gpgcheck=1

            gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch

            enabled=1

            autorefresh=1

            type=rpm-md

        save & exit the file.

        3. Use below rpm command on all three servers to import Elastic’s public signing key.

            # rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

        4. Add the following lines in /etc/hosts file on all three servers

            # vi /etc/hosts

           <IP of ES server1>             <Hostname of ES server1>

           <IP of ES server2>             <Hostname of ES server2>

           <IP of ES server3>             <Hostname of ES server3>

        5. Install Java on all three servers using yum / dnf command.

            # dnf install java-openjdk -y

        6. Install Elasticsearch using beneath dnf command on all three servers.

            # dnf install elasticsearch -y

        7. Run below commands on all 3 servers.

            #cd /usr/share/elasticsearch/bin

            #sudo ./elasticsearch-plugin install discovery-ec2

        8. Configure Elasticsearch, edit the file “/etc/elasticsearch/elasticsearch.yml” on all the three servers and add the followings.

            # vim /etc/elasticsearch/elasticsearch.yml

           …………………………………………

           cluster.name: elkapplicationname

           network.host: <Ip of current server you are in>

           http.port: 9200

           discovery.seed_hosts: ["<IP of ES server1> ", "<IP of ES server2> ", "<IP of ES server3> "]

          cluster.initial_master_servers: ["<IP of ES server1> ", "<IP of ES server2> ", "<IP of ES server3> "]

           ……………………………………………

Note: On Each node, add the correct  current ip address in network.host parameter, all 3 ES server ip’s in discovery.seed_hosts parameter, and  cluster.initial_master_servers parameter and other parameters will remain the same.

        9. Enable and start the Elasticsearch service on all three servers using following systemctl command.

            # systemctl daemon-reload

            # systemctl enable elasticsearch.service

            # systemctl start elasticsearch.service

      10. Use below ‘ss’ command to verify whether elasticsearch node is start listening on 9200 port.

            # ss -tunlp | grep 9200

      11. Use following curl commands to verify the Elasticsearch cluster status.

            #curl -X GET  http://< IP of ES server>:9200/_cluster/health?pretty

      If healthy, then status will be Green and also verify no: of nodes and no: of data nodes.



Step:- 2  Install package for Logstash

Install and Configure Logstash
Perform the following steps on both Logstash servers.

Login to both the nodes

Set the hostname using following hostnamectl command.
# hostnamectl set-hostname "<logstash servername>"

       2. Add the following entries in /etc/hosts file in both logstash servers.

          #vi /etc/hosts

         <IP of ES server1>             <Hostname of ES server1>

         <IP of ES server2>             <Hostname of ES server2>

         <IP of ES server3>             <Hostname of ES server3>

       3. Configure Logstash repository on both the nodes, create a file logstash.repo under the folder /etc/yum.repos.d/ with following content.

           # vi /etc/yum.repos.d/logstash.repo

           [elasticsearch-7.x]

           name=Elasticsearch repository for 7.x packages

           baseurl=https://artifacts.elastic.co/packages/7.x/yum

           gpgcheck=1

           gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch

           enabled=1

           autorefresh=1

           type=rpm-md

       4. Run the following rpm command to import the signing key.

           # rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

       5. Install Java OpenJDK on both the nodes using following dnf command.

           # dnf install java-openjdk -y

       6. Run the following dnf command from both the nodes to install logstash.

           # dnf install logstash -y

       7. Create a logstash conf file, for that first we have copy sample logstash file under ‘/etc/logstash/conf.d/

           # cd /etc/logstash/

           # cp logstash-sample.conf conf.d/logstash.conf

       8. Edit conf file and update the following content.

           # vi conf.d/logstash.conf

           input {

           beats {

           port => 5044

            }

           }

 

           output {

                elasticsearch {

                      hosts => ["http:// <IP of ES server1>:9200", "http:// <IP of ES server2>:9200", "http:// <IP of ES server3>:9200"]

                      index => "%{[@metadata][beat]}-%{[@metadata][version]}-%{+YYYY.MM.dd}"

                      #user => "elastic"

                     #password => "changeme"

                  }

          }

       Note: Under output section, in hosts parameter specify FQDN of all three Elasticsearch nodes, other parameters leave as it is.

       9. Now enable and start Logstash service, run the following systemctl commands on both the nodes.

           # systemctl eanble logstash

           # systemctl start logstash

      10. Use below ss command to verify whether logstash service start listening on 5044.

           # ss -tunlp | grep 5044



Step:- 3  Install package for Kibana

Install and Configure Kibana:
Login to Kibana node, set the hostname with hostnamectl command.
# hostnamectl set-hostname "kibana"

       2. Edit /etc/hosts file and add the following lines.

           <IP of ES server1>             <Hostname of ES server1>

           <IP of ES server2>             <Hostname of ES server2>

           <IP of ES server3>             <Hostname of ES server3>

       3. Setup the Kibana repository using following.

          # vi /etc/yum.repos.d/kibana.repo

          Create this file and paste below contents in it.

          [elasticsearch-7.x]

          name=Elasticsearch repository for 7.x packages

          baseurl=https://artifacts.elastic.co/packages/7.x/yum

          gpgcheck=1

          gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch

          enabled=1

          autorefresh=1

          type=rpm-md

 Then run this command.

           # rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

       4. Execute below dnf command to install kibana.

           # yum install kibana -y

       5. Configure Kibana by editing the file “/etc/kibana/kibana.yml”.

           # vim /etc/kibana/kibana.yml

           …………

           server.host: "kibana"

           server.name: "kibana"

           elasticsearch.hosts: ["http:// <IP of ES server1>:", "http:// <IP of ES server2>:9200", "http:// <IP of ES server3>:9200"]

            …………

       Note:

       Update server.host, server.name parameters with Kibana server host and name and in elasticsearch.hosts parameter specify FQDN of all three Elasticsearch nodes.

       If port is commented, then uncomment it.

       6. Enable and start kibana service.

          # systemctl enable kibana

          # systemctl start kibana

       7. Access Kibana portal / GUI using the following URL:

           http://<kibana-server-ip>:5601

Step:- 4  Basic Authentication for ELK-stack

Basic Authentication in ELK

Login into all 3 Elastic search instances as a root user and run below 5 steps on them.

     1. Edit elasticsearch.yaml file append these 5  lines in that file as below

          #vi /etc/elasticsearch/elasticsearch.yml

          xpack.security.enabled: true                                                                            #It enables security, transport TLS/SSL must also be enable
          xpack.security.transport.ssl.enabled: true                                                        #ssl enabled
          xpack.security.transport.ssl.verification_mode: certificate                               #changes verification mode to certificate
          xpack.security.transport.ssl.keystore.path: elastic-certificates.p12                   
          xpack.security.transport.ssl.truststore.path: elastic-certificates.p12

     2. Generate below certificates in /usr/share/elasticsearch/bin directory  in any one server and then copy generated certificates to a /etc/elasticsearch directory in all the 3 nodes.

          cd  /usr/share/elasticsearch/bin

         # ./elasticsearch-certutil ca
         # ./elasticsearch-certutil cert --ca elastic-stack-ca.p12

         # chmod 755 elastic-certificates.p12

         # scp i <pem-key>  elastic-certificates.p12 centos@<ES-server-ip>:/home/centos/     

         # cp elastic-certificates.p12 /etc/elasticsearch 

                                                                       

     3. Update password in keystore on all 3 nodes:

          # cd /usr/share/elasticsearch/bin

         # ./elasticsearch-keystore add xpack.security.transport.ssl.keystore.secure_password
         # ./elasticsearch-keystore add xpack.security.transport.ssl.truststore.secure_password

     4. Restart es on all 3 nodes

         # systemctl stop elasticsearch.service
         # systemctl start elasticsearch.service
         # systemctl status elasticsearch.service # check status.

     5. Gererate password for inbuilt users:

        # ./elasticsearch-setup-passwords auto # generates updated password for user elastic, kibana, kibana_system, logstash_system, beats_system, apm_system and remote_monitoring_user.



Log into Kibana server as a root user and add Kibana user and password in kibana.yaml file generated for kibana user from previous step.

         # vi /etc/kibana/kibana.yml

         elasticsearch.username: "kibana"

         elasticsearch.password: "kibana-password" # update kibana-password with password for kibana usergenerated in step 4.5

     Then restart the kibana service:

         # service kibana stop

        # service kibana start

        # service kibana status

     Try accessing kibana UI using elastic as user and its corresponding password generated in step5.

         http://<kibana-server-ip>:5601 # access using elastic user credentials



Log into 2 Logstash servers as a root user.

     Update the elastic user and its respective password generated in step 4.5 in logstash.conf file under output section:

         # cd /etc/logstash/conf.d

         # vi  logstash.conf

          user => "elastic"

          password => "elastic-password"

     Restart the logstash service.

           #systemctl stop logstash
           #systemctl start logstash
           #systemctl status logstash



         

         



                 

     



