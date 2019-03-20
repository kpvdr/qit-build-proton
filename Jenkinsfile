pipeline {
    agent {
        dockerfile {
            additionalBuildArgs '--build-arg USER_ID=$(id -u) --build-arg GROUP_ID=$(id -g)'
            args '-v /var/lib/jenkins/workspace/install:/install'
        }
    }

    stages {
        stage('Clean') {
            steps {
                sh './scripts/clean.sh'
            }
        }

        stage('Get Source') {
            steps {
                sh './scripts/get-source.sh'
            }
        }

        stage('Build (Py3)') {
            steps {
                sh './scripts/build-py3.sh'
            }
        }

        stage('Install (Py3)') {
            steps {
                sh './scripts/install-py3.sh'
            }
        }

        stage('Build (Py2)') {
            steps {
                sh './scripts/build-py2.sh'
            }
        }

        stage('Install (Py2)') {
            steps {
                sh './scripts/install-py2.sh'
            }
        }

        stage('Check') {
            steps {
                sh './scripts/check-install.sh'
            }
        }
    }
}
