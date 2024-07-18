pipeline {
    agent any
    
    environment {
        VENV_PATH = 'venv'
        FLASK_APP = 'myproject.py'
        PATH = "/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$VENV_PATH/bin"
    }
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/nickphoon/test.git'
            }
        }
        stage('Setup Virtual Environment') {
            steps {
                // Use Docker image to set up virtual environment
                        sh 'python -m venv $VENV_PATH'
                    
                
            }
        }
        stage('Install dependencies') {
            steps {
                // Use Docker image to install dependencies
                script {
                    docker.image('python:3.9-slim').inside {
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
                // Use Docker image to run the Flask app
                script {
                    docker.image('python:3.9-slim').inside {
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
