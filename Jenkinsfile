pipeline {
    agent {
        docker {
            image 'python:3.8'  // Specify the Python Docker image version
            args '-u root'      // Run as root user to avoid permission issues
        }
    }

    environment {
        VENV_PATH = 'venv'
        FLASK_APP = 'myproject.py'
        PATH = "/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$VENV_PATH/bin"
    }
    
    stages {
        stage('Check Docker') {
            steps {
                sh 'docker --version'
            }
        }
        
        stage('Clone Repository') {
            steps {
                script {
                    // Ensure we are in a workspace directory
                    dir('workspace') {
                        git branch: 'main', url: 'https://github.com/nickphoon/test.git'
                    }
                }
            }
        }
        
        stage('Setup Virtual Environment') {
            steps {
                script {
                    // Ensure we are in a workspace directory
                    dir('workspace') {
                        sh 'python -m venv $VENV_PATH'
                    }
                }
            }
        }
        
        stage('Install dependencies') {
            steps {
                script {
                    // Ensure we are in a workspace directory
                    dir('workspace') {
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
                    // Ensure we are in a workspace directory
                    dir('workspace') {
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
                // Ensure we are in a workspace directory
                dir('workspace') {
                    sh 'rm -rf $VENV_PATH'
                }
            }
        }
    }
}
