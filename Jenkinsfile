#!groovy
node {

    def dockerImage = null

    stage('Checkout') {
        checkout scm
    }

    stage('Build') {
        dockerImage = docker.build("rgielen/logstash-grok-patterns")
    }

    stage('Test') {
        dockerImage.inside {
            sh 'ruby test/test.rb'
        }
    }

    stage('Push') {
        docker.withRegistry('', 'hub.docker.com-rgielen') {
            dockerImage.push()
        }
    }

}
