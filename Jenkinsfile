pipeline {
    agent any
    
    environment {
        dockerImage = ''
        dockerContainer = ''
        VENV_PATH = '/opt/venv'
        FLASK_APP = 'myproject.py'
        PATH = "/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/venv/bin"
    }
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/nickphoon/test.git'
            }
        }
        stage('Install dependencies') {
            steps {
                // Install any dependencies listed in requirements.txt
                sh 'bash -c "pip install -r requirements.txt"'
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
        stage('Deploy Flask App') {
            steps {
                script {
                    // Run the Flask app
                    sh 'FLASK_APP=$FLASK_APP flask run --host=0.0.0.0 --port=5000 &'
                }
            }
        }
    }
    post {
        always {
            script {
                echo 'Cleaning up...'
            }
        }
    }
}
