- Setup and run Docker Desktop, then open a console and cd into your projects root.
  To run OpenCode in your project-folder with different models use below docker run commands:

Public models in the cloud:

- Big Pickle, this is OpenCode's default model: 
  docker run -it --rm -v "%cd%:/workspace" -w /workspace ghcr.io/anomalyco/opencode

- RunPod's Public Endpoint for qwen3-32b:
  set RUNPOD_API_KEY=*********************   ( the value you defined in the RunPod Credentials API Keys Tab for api.runpod.ai )
  docker run -it --rm -e RUNPOD_API_KEY=%RUNPOD_API_KEY% -v "%cd%:/workspace" -w /workspace ghcr.io/anomalyco/opencode --model runpod-qwen/qwen3-32b

- RunPod's Public Endpoint for gpt-oss-120b:
  set RUNPOD_API_KEY=*********************   ( the value you defined in the RunPod Credentials API Keys Tab for api.runpod.ai )
  docker run -it --rm -e RUNPOD_API_KEY=%RUNPOD_API_KEY% -v "%cd%:/workspace" -w /workspace ghcr.io/anomalyco/opencode --model runpod-gpt/gpt-oss-120b

Models hosted on own private cloud hardware:

1. Start a Pod:
- Login to RunPod.io
- Check that the secret AllPods_VLLM_API_KEY is defined
- Got to Account > Templates
- Select template "AAC-Qwen3.5-35B-A3B-FP8-Template" and click "Deploy"
- Select GPU and click "Deploy Pod"
- Wait until Container-Log shows  "Application startup complete." 
- Copy the pod's ID and update the "baseURL" in opencode.json: i.e. "baseURL": "https://xxxxxxxxx-8000.proxy.runpod.net/v1"

2. Run OpenCode:
- Private Pod Endpoint at RunPod for "inland_gold_dolphin":
  set RUNPOD_VLLM_API_KEY=*********************   ( the value you defined in the RunPod Secret AllPods_VLLM_API_KEY )
  docker run -it --rm -e RUNPOD_VLLM_API_KEY=%RUNPOD_VLLM_API_KEY% -v "%cd%:/workspace" -w /workspace ghcr.io/anomalyco/opencode --model runpod-pod/qwen-3.5-35b
  
  
  
  NOT JET WORKING
  
  - Private Serverless Endpoint at RunPod for "inland_gold_dolphin":
  set RUNPOD_API_KEY=*********************
  docker run -it --rm -e RUNPOD_API_KEY=%RUNPOD_API_KEY% -v "%cd%:/workspace" -w /workspace ghcr.io/anomalyco/opencode --model runpod-serverless/qwen-35-35b
  