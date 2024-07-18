pipeline {
    agent any
    
    environment {
        VENV_PATH = 'venv' // Changed to a relative path for easier management
        FLASK_APP = 'myproject.py'
        PATH = "/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:venv/bin"
    }
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/nickphoon/test.git'
            }
        }
        stage('Setup Virtual Environment') {
            steps {
                script {
                    // Create a virtual environment
                    sh 'python -m venv $VENV_PATH'
                }
            }
        }
        stage('Install dependencies') {
            steps {
                script {
                    // Activate the virtual environment and install dependencies
                    sh 'bash -c "source $VENV_PATH/bin/activate && pip install --upgrade pip && pip install -r requirements.txt"'
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
                    // Activate the virtual environment and run the Flask app
                    sh 'bash -c "source $VENV_PATH/bin/activate && FLASK_APP=$FLASK_APP flask run --host=0.0.0.0 --port=5000 &"'
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
