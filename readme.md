# Opencode Usage

1. Prerequisits: RunPod.io Account, [My opencode setup](setup-opencode.md)

2. Go to https://RunPod.io and deploy a pod from one of your templates

3. Start DockerDesktop

4. Start Console
```
cd into your project
set RUNPOD_ID=xxxxxx                                 ... see in RunPod.io the running Pod's Id 
set RUNPOD_POD_API_KEY=yyyyyy                        ... see in RunPod.io Secrets the MY_PODS_API_KEY 
opencode --model runpod-pod/Qwen3.8-27B-UD-Q4_K_XL
```
