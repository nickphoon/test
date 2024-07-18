pipeline {
    agent any
    environment {
        dockerImage = ''
        dockerContainer = ''
    }
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/nickphoon/test.git'
            }
        }
        
        stage('Dependency Check') {
            steps {
                echo 'Running dependency check...'
            }
        }
        stage('UI Testing') {
            steps {
                echo 'Running UI tests...'
            }
        }
    }
    post {
        always {
            script {
                if (dockerContainer) {
                    bat "docker stop ${dockerContainer}"
                }
            }
        }
    }
}
