# Setup Docker
- Install DockerDesktop
- Enable host-side TCP support if you want to run local llm models in docker's model-runner:
    ```
    docker desktop enable model-runner --tcp=12434
    ```
# Setup OpenCode
- Clone this repo to your local computer
- Extend the environment variable PATH with the path to the local [./cmd](./cmd/) folder within this repo. 
  To test the setup, got to a arbitrary folder, open a new console and enter:
    ```
    opencode
    ```
  After a few seconds you should see the opencode UI. 
  At the very first startup it may take longer since the docker-image has to be downloaded once.
  
# New models
- If you want to use new models add them to [./config/opencode.jsonc](./config/opencode.jsonc) in this repo.

# Update OpenCode
- To use the newest version of OpenCode 
- Delete the old image:   ```docker rmi ghcr.io/anomalyco/opencode```
- Download the new image: ```docker pull ghcr.io/anomalyco/opencode```
- List the digest:        ```docker images --digests```
- Open [./cmd/opencode.cmd](./cmd/opencode.cmd) and set at the end the new sha256 value you see in the digest list.
    ```
    set OPENCODE_IMAGEFILE=ghcr.io/anomalyco/opencode@sha256:.................
    ```
	Like this your opencode setup is pinned to that exact version. 
	If needed you can rollback to a older version by just setting the old sha256 value.