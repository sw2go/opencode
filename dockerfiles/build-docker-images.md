# Create custom image
- Create a docker file containing the tooling you need
- e.g. Dockerfile.opencode-net10sdk containing opencode and the DOTNET 10 sdk
- go to the folder containing the docker image e.g. this [./dockerfiles](./) and run a docker build, here you see some samples:
    ```
	docker build -f Dockerfile.opencode-net10sdk -t opencode-dotnet10sdk .
	docker build -f Dockerfile.opencode-docs     -t opencode-docs .
	```
	