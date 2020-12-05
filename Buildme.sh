docker build -t jstrader/docker-amd:arm32v7 -f .\Dockerfile.arm32v7 ./
docker push jstrader/docker-amd:arm32v7
docker build -t jstrader/docker-amd:arm64v8 -f .\Dockerfile.arm64v8 ./
docker push jstrader/docker-amd:arm64v8
docker build -t jstrader/docker-amd:amd64 -f .\Dockerfile ./
docker push jstrader/docker-amd:amd64
docker manifest create jstrader/docker-amd:latest --amend jstrader/docker-amd:arm32v7 --amend jstrader/docker-amd:arm64v8 --amend jstrader/docker-amd:amd64
docker manifest push jstrader/docker-amd:latest
