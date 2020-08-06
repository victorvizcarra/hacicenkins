pipeline {
    agent {
        docker { image 'node:14-alpine' }
    }
    stages {
        stage('Test1') {
            steps {
                sh 'node --version'
            }
        }
    }
}
