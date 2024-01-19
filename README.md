# Flutter - Docker - Docker-Compose & Environment Variables

This project is to test and show how to use environment variables in a Flutter project, and how to use Docker and Docker-Compose to run the project.

## Introduction

This is a basic project to cover 3 topics:
- How wo pass environment variables from Docker to Flutter
- How to create a Docker image with the release version and web server with Nginx
- How to use Docker-compose to create a container to run the Flutter web app with dynamic environment variables

## Getting Started
### Flutter Project
I created the project with VSCode and the Flutter extension. I created a Flutter application with descriptive comments and tests.
I changed the `main.dart` file to capture and show the environment variables.
Environment variables are read using the method String.fromEnvironment().

### Dockerfile
The Dockerfile has two parts:   
1. The first part is to build the Flutter project and create the release version.
2. The second part is to create a Nginx web server and copy the release version to the web server, this will be the final docker image.

The key points with the environment variables are in the first part of the Dockerfile:
- To define the arguments Dockerfile will receive (witht the environment variables)
ARG VARC
ARG VARF
- To define the environment variables that will be used in the Flutter project on the build, using the `--build-arg` to pass the environment variables to the Flutter project.
![App Screenshot](https://github.com/darksignal/flutter_envvar_docker/blob/main/screenshots/Screenshot1.png)

### Environment variables file
I created a .env file that I will use as dynamic parameter to run the docker-compose file.
It contains only the environment variable I want to send to the Flutter project.

ENV_VARF="Found in file variable.env!!!"

### Docker-Compose file and execution.
In the Docker-Compose file, I defined the environment variables that will be used in the image build stage in Dockerfile.
![App Screenshot](https://github.com/darksignal/flutter_envvar_docker/blob/main/screenshots/Screenshot2.png)

```	
docker-compose --env-file variable.env up -d
```	

## Conclusion
With this I could have different .env files and run the image with different values.
For a better result I would use the environment variable values to name the image file and container to avoid conflicts.


## Resources
A few resources to get you started with Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
