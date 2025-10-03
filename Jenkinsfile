pipeline {
  agent any

  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhubb') // Jenkins credentials ID
    DOCKERHUB_REPO = "ivosalumbides/jenkins_prac"
    IMAGE_TAG = "${BUILD_NUMBER}"
  }

  stages {
    stage('Checkout') {
      steps {
        git branch: 'main',
            url: 'https://github.com/manuelosalumbidesii/jenkins_prac.git'
      }
    }

    stage('Build Docker Image') {
      steps {
        sh 'docker build -t ${DOCKERHUB_REPO}:${IMAGE_TAG} .'
        sh 'docker tag ${DOCKERHUB_REPO}:${IMAGE_TAG} ${DOCKERHUB_REPO}:latest'
      }
    }

    stage('Login to DockerHub') {
      steps {
        sh 'echo ${DOCKERHUB_CREDENTIALS_PSW} | docker login -u ${DOCKERHUB_CREDENTIALS_USR} --password-stdin'
      }
    }

    stage('Push Docker Image') {
      steps {
        sh 'docker push ${DOCKERHUB_REPO}:${IMAGE_TAG}'
        sh 'docker push ${DOCKERHUB_REPO}:latest'
      }
    }
  }

  post {
    success {
      echo "✅ Docker image pushed successfully: ${DOCKERHUB_REPO}:${IMAGE_TAG}"
    }
    failure {
      echo "❌ Pipeline failed. Check logs for detailsss."
    }
  }
}
