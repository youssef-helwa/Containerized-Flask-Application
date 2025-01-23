#Install Java
echo "--------------------Installing Java--------------------"
sudo apt-get update -y
sudo apt upgrade -y 
sudo apt-get install openjdk-8-jdk -y

#Install Jenkins 
echo "--------------------Installing Jenkins--------------------"
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins


#sudo nano /etc/default/jenkins
#JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64







#Install docker
echo "--------------------Installing Docker--------------------"
sudo apt-get update -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io -y

#Install EksCtl
echo "--------------------Installing EKS-CTL--------------------"
sudo curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin

#Install Kubectl
echo "----------"----------Installing Kubectl"--------------------"
sudo curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(<kubectl.sha256)  kubectl" | sha256sum --check
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

#Install Minikube
echo "--------------------Installing Minikube--------------------"
sudo curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

#Install AWS-CLI
echo "--------------------Installing AWS-CLI--------------------"
sudo apt-get install zip -y
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip
sudo ./aws/install

#Add docker to sudo group
echo "--------------------Add Docker to Sudo group--------------------"
sudo usermod -aG docker $USER && newgrp docker && sudo chmod 777 /var/run/docker.sock

#Start Minikube
echo "--------------------Start Minikube--------------------"
minikube start

#Show Jenkins Password
echo "--------------------Jenkins Password--------------------"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword