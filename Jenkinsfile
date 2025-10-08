pipeline {
  agent any

  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhub') // Jenkins credentials ID
    DOCKERHUB_REPO = "ivosalumbides/jenkins_prac"
    VERSION_TAG = "v${BUILD_NUMBER}" // Dynamic version tag: v1, v2, v3...
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
        sh 'docker build -t ${DOCKERHUB_REPO}:${VERSION_TAG} .'
        sh 'docker tag ${DOCKERHUB_REPO}:${VERSION_TAG} ${DOCKERHUB_REPO}:latest'
      }
    }

    stage('Login to DockerHub') {
      steps {
        sh 'echo ${DOCKERHUB_CREDENTIALS_PSW} | docker login -u ${DOCKERHUB_CREDENTIALS_USR} --password-stdin'
      }
    }

    stage('Push Docker Image') {
      steps {
        sh 'docker push ${DOCKERHUB_REPO}:${VERSION_TAG}'
        sh 'docker push ${DOCKERHUB_REPO}:latest'
      }
    }
  }

  post {
    success {
      echo "✅ Docker image pushed successfully: ${DOCKERHUB_REPO}:${VERSION_TAG}"
    }
    failure {
      echo "❌ Pipeline failed. Check logs for detailssss."
    }
  }
}
