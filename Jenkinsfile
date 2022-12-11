def COLOR_MAP = [
    'SUCCESS': 'good', 
    'FAILURE': 'danger',
]
pipeline {
  agent any
  environment {
    WORKSPACE = "${env.WORKSPACE}"
  }
  tools {
    maven 'localMaven'
    jdk 'localJdk'
  }
  stages {

    stage ('Scan using Gradle') {
        steps {
            withSonarQubeEnv(installationName: 'SonarQubeScanner', credentialsId: 'SonarQubeSecret') {
            sh "./sample-spring-postgres-app/gradlew sonarqube \
              -Dsonar.projectKey=${serviceName} \
              -Dsonar.host.url=${env.SONAR_HOST_URL} \
              -Dsonar.login=${env.SONAR_AUTH_TOKEN} \
              -Dsonar.projectName=${serviceName} \
              -Dsonar.projectVersion=${BUILD_NUMBER}"
            }
          }
    }
    stage('Build') {
      steps {
        sh "./sample-spring-postgres-app/gradlew jibDockerBuild"
      }
      post {
        success {
          echo ' now Archiving '
          archiveArtifacts artifacts: '**/*.war'
        }
      }
    }
  }
}


//     stage('Unit Test'){
//         steps {
//             sh 'mvn test'
//         }
//     }
//     stage('Integration Test'){
//         steps {
//           sh 'mvn verify -DskipUnitTests'
//         }
//     }
//     stage ('Checkstyle Code Analysis'){
//         steps {
//             sh 'mvn checkstyle:checkstyle'
//         }
//         post {
//             success {
//                 echo 'Generated Analysis Result'
//             }
//         }
//     }
//     stage('SonarQube Scanner') {
//       steps {
        
//         withSonarQubeEnv('SonarQube') {

//         sh """
//         mvn sonar:sonar \
//       -Dsonar.projectKey=JavaWebApp \
//       -Dsonar.host.url=http://172.31.31.247:9000 \
//       -Dsonar.login=e0c55b9178ad2365bf7b3848c06780ed2374a22b
//       """
//         }
//       }
//     }
//     stage('Quality Gate'){
//         steps {
//           waitForQualityGate abortPipeline: true

//         }
//     }
    
//     stage("Upload artifact to Nexus"){
//       steps{
//         sh 'mvn clean deploy -DskipTests'
//       }
//       }

//   }
// }




  //   stage('Upload to Artifactory') {
  //     steps {
  //       sh "mvn clean deploy -DskipTests"
  //     }
  //   }
  //   stage('Deploy to DEV') {
  //     environment {
  //       HOSTS = "dev"
  //     }
  //     steps {
  //       sh "ansible-playbook ${WORKSPACE}/deploy.yaml --extra-vars \"hosts=$HOSTS workspace_path=$WORKSPACE\""
  //     }
  //    }
  //   // stage('Approval for stage') {
  //   //   steps {
  //   //     input('Do you want to proceed?')
  //   //   }
  //   // }
  //   stage('Deploy to Stage') {
  //     environment {
  //       HOSTS = "stage" // Make sure to update to "stage"
  //     }
  //     steps {
  //       sh "ansible-playbook ${WORKSPACE}/deploy.yaml --extra-vars \"hosts=$HOSTS workspace_path=$WORKSPACE\""
  //     }
  //   }
  //   stage('Approval') {
  //     steps {
  //       input('Do you want to proceed?')
  //     }
  //   }
  //   stage('Deploy to PROD') {
  //     environment {
  //       HOSTS = "prod"
  //     }
  //     steps {
  //       sh "ansible-playbook ${WORKSPACE}/deploy.yaml --extra-vars \"hosts=$HOSTS workspace_path=$WORKSPACE\""
  //     }
  //   }
  // }
  // post {
  //   always {
  //       echo 'Slack Notifications.'
  //       slackSend channel: '#mbandi-jenkins-cicd-pipeline-alerts', //update and provide your channel name
  //       color: COLOR_MAP[currentBuild.currentResult],
  //       message: "*${currentBuild.currentResult}:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} \n More info at: ${env.BUILD_URL}"
  //   }
  // }



//slackSend channel: '#mbandi-cloudformation-cicd', message: "Please find the pipeline status of the following ${env.JOB_NAME ${env.BUILD_NUMBER} ${env.BUILD_URL}"
