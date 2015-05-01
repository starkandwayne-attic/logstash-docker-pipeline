Pipeline to deploy Logstash Docker
==================================

This project is an example http://concourse.ci pipeline for deploying the https://github.com/cloudfoundry-community/logstash-docker-boshrelease/ BOSH release.

There are several `pipeline*.yml` to choose from:

-	`pipeline-try-anything.yml` will deploy a single VM from current upstream BOSH releases & stemcells. Any new releases or stemcells, or changes to `try-anything/environment` or `try-anything/pipeline` templates will trigger a new deployment. It will indeed "try anything".
-	`pipeline-try-first-then-production.yml` will run two deployments. The first BOSH deployment is like `pipeline-try-anything.yml`. If it successfully deploys, then the winning combination of release/stemcell/templates is passed through to the production deployment.

![try-anything-production](http://cl.ly/image/3w15021g2c1W/try-anything_straight_to_production.png)

-	`pipeline-try-pre-prod-prod.yml` protects production by one additional stage `pre-production`. The `pre-production` stage is triggered by any successful `try-anything` deployment. It first deploys based on the last successful `production`, then upgrades to the last successful `try-anything`. If success, this becomes the candidate for `production`'s next deployment.

The example pipelines all assume the deployments are via the same BOSH - as such only the entry deployment `try-anything` is responsible for uploading releases & stemcells. Other deployments assume that releases & stemcells are uploaded, and benefit from packages being pre-compiled.

Usage
-----

Building/updating the base Docker image for tasks
-------------------------------------------------

Each task within all job build plans uses the same base Docker image for all dependencies. Using the same Docker image is a convenience. This section explains how to re-build and push it to Docker Hub.

All the resources used in the pipeline are shipped as independent Docker images and are outside the scope of this section.

```
./run-pipeline.sh pipeline-build-docker-image.yml credentials.yml job-build-task-image
```

This will ask your targeted Concourse to pull down this project repository, and build the `task_docker_image/Dockerfile`, and push it to a Docker image on Docker Hub.
