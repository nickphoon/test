pipeline {
    agent any
    tools {python3 "PYTHON3"}
    environment {
        dockerImage = ''
        dockerContainer = ''
        VENV_PATH = 'myprojectenv'
        FLASK_APP = 'myproject.py'
        PATH = "/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/path/to/python/bin"
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
                    // Check for the virtual environment, 
                    // create it if it doesn't exist
                    sh 'bash -c "python3 -m venv $VENV_PATH"'
                    // Activate the virtual environment
                    sh 'bash -c "source $VENV_PATH/bin/activate"'
                }
            }
        }
         stage('Install dependencies') {
            steps {
                // Install any dependencies listed in requirements.txt
                sh 'bash -c "source $VENV_PATH/bin/activate && pip install -r requirements.txt"'
                
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
                sh 'rm -rf ${VIRTUAL_ENV_DIR}'
                if (dockerContainer) {
                    bat "docker stop ${dockerContainer}"
                }
            }
        }
    }
}
