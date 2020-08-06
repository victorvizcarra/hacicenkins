node {
    
def customImage 
    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */

        checkout scm
    }
    
   stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */

        customImage = docker.build("yenigul/hacicenkins")

    }

    stage('Push image') {
        /* Finally, we'll push the image with two tags:
         * First, the incremental build number from Jenkins
         * Second, the 'latest' tag.
         * Pushing multiple tags is cheap, as all the layers are reused. */
        docker.withRegistry('https://registry.hub.docker.com', 'yenigul-dockerhub') {
            customImage.push("${env.BUILD_NUMBER}")
            customImage.push("latest")
        }
    }
}
