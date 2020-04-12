## Using localstack
Scripts for creating localstack resources should be placed here:
    
    .localstack/setup/aws-setup.sh

## Docker compose

### up / down

Run with -d for detached mode

    docker-compose up -d

Stop, without losing container

    docker-compose stop

Stop, container, network, etc...

    docker-compose down

### run - and get shell using the service name, with docker-compose

    docker-compose exec bash

#### References

https://stackoverflow.com/a/39150040/178808
https://docs.docker.com/compose/compose-file/#dockerfile

# References
https://github.com/localstack/localstack/blob/master/docker-compose.yml
https://joerg-pfruender.github.io/software/docker/microservices/testing/2020/01/25/Localstack_in_Docker.html


