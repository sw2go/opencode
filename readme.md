# Opencode Usage
Use this guide to setup and run OpenCode with your favorite AI privately and securely. 
To prevent OpenCode from accessing all files on your computer we don't install OpenCode on the computer.
Instead we run it from within docker and mount only the current folder as the working directory.

- Prerequisits: [My RunPod setup](setup-runpod.md), [My OpenCode setup](setup-opencode.md)

- Deploy a pod at https://RunPod.io and remember the Pod's Id

- Start DockerDesktop

- Start Console
    ```
    cd into your-projects-folder
    set RUNPOD_ID=xxxxxx                                 ... see in RunPod.io the running Pod's Id 
    set RUNPOD_POD_API_KEY=yyyyyy                        ... see in RunPod.io Secrets the MY_PODS_API_KEY 
    opencode --model runpod-pod/Qwen3.8-27B-UD-Q4_K_XL
    ```
	The folder from which you launch OpenCode is mounted by Docker as the OpenCode's workspace. Changes made by OpenCode in that folder are preserved on the host.

- Continue Session
    ```
    opencode opencode -s ses_f3802d016ffeDDdyW07OZoUDjX
    ```    
	You can find old session IDs in ./share/log/opencode.log. The log is written to the local Share folder, which Docker mounts to persist OpenCode shared data on the host.


