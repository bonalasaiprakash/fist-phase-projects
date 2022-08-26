Installing Jenkins on Ubuntu 18.04/20.04
To install Jenkins on your Ubuntu system, follow these steps:

01. Install Java.
sudo apt update
sudo apt install openjdk-8-jdk

02. Add the Jenkins Debian repository.
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

03. Install Jenkins.
sudo apt update
sudo apt install jenkins

04. check jenkins status
systemctl status jenkins

output should be:
jenkins.service - LSB: Start Jenkins at boot time
Loaded: loaded (/etc/init.d/jenkins; generated)
Active: active (exited) since Wed 2018-08-22 13:03:08 PDT; 2min 16s ago
    Docs: man:systemd-sysv-generator(8)
    Tasks: 0 (limit: 2319)
CGroup: /system.slice/jenkins.service

05. Access the jenkins
http://your_ip_or_domain:8080

# get the password use below path and provide in UI
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

