pipeline {
    agent any

    environment {
        VENV_PATH = 'venv'
        FLASK_APP = 'workspace/app.py'  // Correct path to the Flask app
        PATH = "$VENV_PATH/bin:$PATH"
        SONARQUBE_SCANNER_HOME = tool name: 'SonarQube Scanner'
        SONARQUBE_TOKEN = 'sqp_61ff14cfe86863be8f964b1ef92094b3a3fc5323'  // Set your new SonarQube token here
        DEPENDENCY_CHECK_HOME = '/var/jenkins_home/tools/org.jenkinsci.plugins.DependencyCheck.tools.DependencyCheckInstallation/OWASP_Dependency-Check/dependency-check'
    }
    
    stages {
        stage('Check Docker') {
            steps {
                sh 'docker --version'
            }
        }
        
        stage('Clone Repository') {
            steps {
                dir('workspace') {
                    git branch: 'main', url: 'https://github.com/nickphoon/test.git'
                }
            }
        }
        
        stage('Setup Virtual Environment') {
            steps {
                dir('workspace/') {
                    sh 'python3 -m venv $VENV_PATH'
                }
            }
        }
        
        stage('Activate Virtual Environment and Install Dependencies') {
            steps {
                dir('workspace/') {
                    sh '. $VENV_PATH/bin/activate && pip install -r requirements.txt'
                }
            }
        }
        
        stage('OWASP Dependency-Check Vulnerabilities') {
      steps {
        dependencyCheck additionalArguments: ''' 
                    -o './'
                    -s './'
                    -f 'ALL' 
                    --prettyPrint''', odcInstallation: 'OWASP Dependency-Check Vulnerabilities'
        
        dependencyCheckPublisher pattern: 'dependency-check-report.xml'
      }
    }
        
        stage('UI Testing') {
            steps {
                script {
                    // Start the Flask app in the background
                    sh '. $VENV_PATH/bin/activate && FLASK_APP=$FLASK_APP flask run &'
                    // Give the server a moment to start
                    sh 'sleep 5'
                    // Debugging: Check if the Flask app is running
                    sh 'curl -s http://127.0.0.1:5000 || echo "Flask app did not start"'
                    
                    // Test a strong password
                    sh '''
                    curl -s -X POST -F "password=StrongPass123" http://127.0.0.1:5000 | grep "Welcome"
                    '''
                    
                    // Test a weak password
                    sh '''
                    curl -s -X POST -F "password=password" http://127.0.0.1:5000 | grep "Password does not meet the requirements"
                    '''
                    
                    // Stop the Flask app
                    sh 'pkill -f "flask run"'
                }
            }
        }
        
        stage('Integration Testing') {
            steps {
                dir('workspace') {
                    sh '. $VENV_PATH/bin/activate && pytest --junitxml=integration-test-results.xml'
                }
            }
        }
        
        stage('Build Docker Image') {
            steps {
                dir('workspace') {
                    sh 'docker build -t flask-app .'
                }
            }
        }
        
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    dir('workspace') {
                        sh '''
                        ${SONARQUBE_SCANNER_HOME}/bin/sonar-scanner \
                        -Dsonar.projectKey=Lab \
                        -Dsonar.sources=. \
                        -Dsonar.inclusions=app.py \
                        -Dsonar.host.url=http://sonarqube:9000 \
                        -Dsonar.login=${SONARQUBE_TOKEN}
                        '''
                    }
                }
            }
        }
        
        stage('Deploy Flask App') {
            steps {
                script {
                    echo 'Deploying Flask App...'
                    // Stop any running container on port 5000
                    sh 'docker ps --filter publish=5000 --format "{{.ID}}" | xargs -r docker stop'
                    // Remove the stopped container
                    sh 'docker ps -a --filter status=exited --filter publish=5000 --format "{{.ID}}" | xargs -r docker rm'
                    // Run the new Flask app container
                    sh 'docker run -d -p 5000:5000 flask-app'
                    sh 'sleep 10'
                }
            }
        }
    }
    
    post {
        failure {
            script {
                echo 'Build failed, not deploying Flask app.'
            }
        }
        always {
            archiveArtifacts artifacts: 'workspace/dependency-check-report/*.*', allowEmptyArchive: true
            archiveArtifacts artifacts: 'workspace/integration-test-results.xml', allowEmptyArchive: true
        }
    }
}
