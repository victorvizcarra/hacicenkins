pipeline {
  environment {
    imagename = "yenigul/hacicenkins"
    registryCredential = 'yenigul-dockerhub'
    dockerImage = ''   
  }
  agent any
  
  stages {
    stage('Cloning Git') {
      steps {
 //   git([url: 'https://github.com/ismailyenigul/hacicenkins.git', branch: 'master', credentialsId: 'ismailyenigul-github-user-token'])
 	checkout scm

      }
    }
    stage('Building image') {
      steps{
        withAWS(credentials: 'ecr-ismail', region: 'us-east-2'){
          

      sh "echo AWSKEY ${AWS_ACCESS_KEY_ID}"


        script {

          dockerImage = docker.build imagename
        }
      }
      }
    }
    stage('Deploy  Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push("$BUILD_NUMBER")
             dockerImage.push('latest')

          }
        }
      }
    }
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $imagename:$BUILD_NUMBER"
         sh "docker rmi $imagename:latest"

      }
    }
  }
}
