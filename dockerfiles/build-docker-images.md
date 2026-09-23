# Create custom image
- Create a docker file containing the tooling you need, 
- e.g. Dockerfile.opencode-net10sdk containing opencode and the DOTNET 10 sdk
- cd into the folder where the dockerfile is located
    ```
	docker build -f Dockerfile.opencode-net10sdk -t opencode-dotnet10sdk .
	docker build -f Dockerfile.opencode-docs     -t opencode-docs .
	```
	