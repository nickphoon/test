pipeline {
    agent any
    
    environment {
        VENV_PATH = '/app/venv'
        FLASK_APP = 'myproject.py'
        PATH = "/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$VENV_PATH/bin"
    }
    stages {
        stage('Clone Repository') {
            steps {
                // Ensure the workspace is clean and clone the repository
                cleanWs()
                git branch: 'main', url: 'https://github.com/nickphoon/test.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    dockerImage = docker.build("my-flask-app:latest")
                }
            }
        }
        stage('Setup Virtual Environment') {
            steps {
                script {
                    // Use the built Docker image to set up virtual environment
                    dockerImage.inside {
                        sh 'python3 -m venv $VENV_PATH'
                    }
                }
            }
        }
        stage('Install dependencies') {
            steps {
                script {
                    // Use the built Docker image to install dependencies
                    dockerImage.inside {
                        sh 'bash -c "source $VENV_PATH/bin/activate && pip install --upgrade pip && pip install -r requirements.txt"'
                    }
                }
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
                    // Use the built Docker image to run the Flask app
                    dockerImage.inside {
                        sh 'bash -c "source $VENV_PATH/bin/activate && FLASK_APP=$FLASK_APP flask run --host=0.0.0.0 --port=5000 &"'
                    }
                }
            }
        }
    }
    post {
        always {
            script {
                echo 'Cleaning up...'
                // Clean up the virtual environment
                sh 'rm -rf $VENV_PATH'
            }
        }
    }
}
