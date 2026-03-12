pipeline {

  agent { label 'ec2' }

  options {
    timestamps()
  }

  stages {

    stage('Checkout Source') {
      steps {
        git branch: 'main', url: 'https://github.com/don-maslanka/katalon_ecs.git'
      }
    }

    stage('Local Smoke Test') {
      steps {
        sh '''
          set -e

          echo "=== BASIC NODE INFO ==="
          hostname
          whoami
          pwd

          echo "=== WORKSPACE CONTENTS ==="
          ls -la
          echo
          find . -maxdepth 2 -type f | sort | head -100 || true

          echo "=== JAVA ==="
          java -version || true

          echo "=== GIT ==="
          git --version || true

          echo "=== KATALON ==="
          which katalonc || true
          katalonc -version || true

          echo "=== ENVIRONMENT ==="
          env | sort
        '''
      }
    }

  }

}
