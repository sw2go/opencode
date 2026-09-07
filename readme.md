# Opencode Usage
Use this guide to setup and run OpenCode with your favorite AI privately and securely. 
To prevent OpenCode from accessing all files on your computer we don't install OpenCode on the computer.
Instead we run it from within docker and mount only the current folder as the working directory.

- Prerequisits: RunPod.io Account, [My OpenCode setup](setup-opencode.md)

- Go to https://RunPod.io and deploy a pod from one of your templates

- Start DockerDesktop

- Start Console
    ```
    cd into your project
    set RUNPOD_ID=xxxxxx                                 ... see in RunPod.io the running Pod's Id 
    set RUNPOD_POD_API_KEY=yyyyyy                        ... see in RunPod.io Secrets the MY_PODS_API_KEY 
    opencode --model runpod-pod/Qwen3.8-27B-UD-Q4_K_XL
    ```
