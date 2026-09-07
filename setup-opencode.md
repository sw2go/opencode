# Setup docker
- Install DockerDesktop
- Enable host-side TCP support if you want to run local llm models in docker's model-runner:
    ```
    docker desktop enable model-runner --tcp=12434
    ```
# Setup opencode
- clone this repo to your local computer
- Extend the environment variable PATH with the path to the local ./cmd folder within this repo
  To test the setup, got to a arbitrary folder, open a new the console and enter
    ```
    opencode
    ```
  After a few seconds you should see the opencode UI (at the very first startup it may take longer since the docker-image has to be downloaded once.)
