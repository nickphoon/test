pipeline {
    agent any
    environment {
        VENV_PATH = 'myprojectenv'
        FLASK_APP = 'myproject.py'
        DOCKER_IMAGE = 'my-flask-app'
    }
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/nickphoon/test.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t $DOCKER_IMAGE .'
                }
            }
        }
        stage('Deploy Flask App') {
            steps {
                script {
                    sh 'docker run -d -p 5000:5000 $DOCKER_IMAGE'
                }
            }
        }
    }
    post {
        always {
            script {
                echo 'Cleaning up...'
                sh 'docker stop $(docker ps -q --filter ancestor=$DOCKER_IMAGE)'
                sh 'docker rm $(docker ps -a -q --filter ancestor=$DOCKER_IMAGE)'
            }
        }
    }
}
