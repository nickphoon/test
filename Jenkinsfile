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
                script {
                    // Ensure the virtual environment path is correct
                    sh 'if [ ! -d "$VENV_PATH" ]; then echo "Virtual environment not found"; exit 1; fi'
                    // Activate the virtual environment and install dependencies
                    sh 'bash -c "source /opt/venv/bin/activate && pip install -r requirements.txt"'
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
                    sh 'bash -c "source /opt/venv/bin/activate && FLASK_APP=$FLASK_APP flask run --host=0.0.0.0 --port=5000 &"'
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
