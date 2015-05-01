Pipeline to deploy Logstash Docker
==================================

This project is an example http://concourse.ci pipeline for deploying the https://github.com/cloudfoundry-community/logstash-docker-boshrelease/ BOSH release.

Building/updating the base Docker image for tasks
-------------------------------------------------

Each task within all job build plans uses the same base Docker image for all dependencies. Using the same Docker image is a convenience. This section explains how to re-build and push it to Docker Hub.

All the resources used in the pipeline are shipped as independent Docker images and are outside the scope of this section.

```
./run-pipeline.sh pipeline-build-docker-image.yml credentials.yml job-build-task-image
```

This will ask your targeted Concourse to pull down this project repository, and build the `task_docker_image/Dockerfile`, and push it to a Docker image on Docker Hub.
