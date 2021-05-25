pipeline {
    tools {
        jdk 'java_home'
    }
  
    environment {
    DOCKER_TAG = getVersion()
    }
    agent any 
        stages {
            stage ('Checkout'){
                steps {
                     echo 'Cloning the git repo'
                     git branch: 'main', url: 'https://github.com/shraddharane1395/CertiProject.git'
                }
               
            }
        
            stage ('Build Docker Image'){
                steps {
                     echo 'Building Docker image'
                     sh " sudo docker build --no-cache -t myimage1 ."
                     sh "sudo docker tag myimage1 shraddharane/newimage2:${DOCKER_TAG} "
                }
               
            }
            
            stage ('Push the image to Docker Hub'){
                steps {
                    echo 'Pushing the image to Docker Hub'
                    withCredentials([string(credentialsId: 'DOCKER-HUB', variable: 'docker_hub_paswd')]) {
                    sh 'sudo docker login -u shraddharane -p ${docker_hub_paswd}'
                    }
                    sh "sudo docker push shraddharane/newimage2:${DOCKER_TAG} "

                }
               
            }
            
            stage ('Invoke ansible'){
                steps {
                     echo 'Invoking Ansible'
                     ansiblePlaybook credentialsId: 'prod-server', disableHostKeyChecking: true, extras: "-e DOCKER_TAG=${DOCKER_TAG}", installation: 'ansible_home', inventory: 'dev.inv', playbook: 'playbook1.yml'
                }
               
            }
        
        }
}
def getVersion(){
    def commitHash = sh returnStdout: true, script: 'git rev-parse --short HEAD'
    return commitHash
    //to pickup latest commit ID and store return value in variable .
}
