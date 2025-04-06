pipeline {
    agent any
    parameters {
        string(name: 'VERSION', defaultValue: '', description: 'Optional: deploy specific version (for rollback)')
    }
    environment {
        APP_NAME = "angular-devops-app"
        BUILD_DIR = "src/dist/angular-devops-app"
    }
    stages {
        stage('Clone Repo') {
            steps {
                git 'https://github.com/GloriaFavourandGrace/Team24-Project.git'
            }
        }
        stage('Build Angular App') {
            steps {
                dir('src') {
                    sh 'npm install'
                    sh 'npm run build'
                }
            }
        }
        stage('Package Artifact') {
            steps {
                script {
                    def version = params.VERSION ?: "v1.0.${BUILD_NUMBER}"
                    env.VERSION = version
                    sh "tar -czf ${APP_NAME}-${version}.tar.gz -C ${BUILD_DIR} ."
                    archiveArtifacts artifacts: "${APP_NAME}-${version}.tar.gz"
                }
            }
        }
        stage('Deploy with Ansible') {
            steps {
                script {
                    def version = params.VERSION ?: "v1.0.${BUILD_NUMBER}"
                    def artifact = "${WORKSPACE}/${APP_NAME}-${version}.tar.gz"
                    ansiblePlaybook(
                        playbook: 'playbook.yml',
                        inventory: 'hosts.ini',
                        extras: "-e version=${version} -e artifact_path=${artifact}"
                    )
                }
            }
        }
    }
    post {
        success {
            echo "Deployed Angular App version ${VERSION ?: "v1.0.${BUILD_NUMBER}"}"
        }
    }
}
