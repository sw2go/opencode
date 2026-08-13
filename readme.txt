Run OpenCode with different LLM's locally and remote
----------------------------------------------------

- Start DockerDesktop

- Enable host-side TCP support if you want to run llm models locally:
  docker desktop enable model-runner --tcp=12434

- Pull a language model to your laptop (local llm):
  docker model pull ai/qwen3-coder

- Inspect the model to check context-size
  docker model inspect ai/qwen3-coder

- If you find context of 4096 it is to small for OpenCode, we have to increase the context window to 32k 
  create a new model variant based on ai/qwen3-coder and name it ai/qwen3-coder:32k
  docker model package --from ai/qwen3-coder --context-size 32768 ai/qwen3-coder:32k

- For RunPod 
  login to https://www.runpod.io/

- If not jet done, create a APIKey for read/write to the .ai endpoint
  RunPod > Settings > API keys

- If no credit left add some
  RunPod > Top Right +








- Go to your project folder and add opencode.json to root with following content:
{
  "$schema": "https://opencode.ai/config.json",
  "provider": {
    "dmr": {
      "name": "Docker Model Runner",
      "npm": "@ai-sdk/openai-compatible",
      "options": {
        "baseURL": "http://host.docker.internal:12434/v1",
        "apiKey": "local-no-key-required"
      },
      "models": {
        "qwen3-coder:32k": { 
        "constraints": {
          "maxContextTokens": 32768,
          "maxOutputTokens": 4096
        }
      }
      }
    }
  },
  "model": "dmr/qwen3-coder:32k"
}

- Open console and cd into your projects root
  cd C:\@DevOps\projects\projectx
  
- Set environment variable RUNPOD_API_KEY
  set RUNPOD_API_KEY=....              ... only if you want to use RunPod
  
- Then run OpenCode with ...
- Big Pickle: 
  docker run -it --rm -v "%cd%:/workspace" -w /workspace ghcr.io/anomalyco/opencode

- Local qwen3-coder:32k:
  docker run -it --rm --add-host=host.docker.internal:host-gateway -v "%cd%:/workspace" -w /workspace ghcr.io/anomalyco/opencode --model dmr/qwen3-coder:32k

- Local devstral-small:24B:
  docker run -it --rm --add-host=host.docker.internal:host-gateway -v "%cd%:/workspace" -w /workspace ghcr.io/anomalyco/opencode --model dmr/devstral-small:24B
  
- RunPod Public Endpoint qwen3-32b:
  (docker run -it --rm -e RUNPOD_API_KEY=%RUNPOD_API_KEY% --add-host=host.docker.internal:host-gateway -v "%cd%:/workspace" -w /workspace ghcr.io/anomalyco/opencode --model runpod-qwen/qwen3-32b)
  docker run -it --rm -e RUNPOD_API_KEY=%RUNPOD_API_KEY% -v "%cd%:/workspace" -w /workspace ghcr.io/anomalyco/opencode --model runpod-qwen/qwen3-32b

- RunPod Public API gpt-oss-120b:
  docker run -it --rm -e RUNPOD_API_KEY=%RUNPOD_API_KEY% -v "%cd%:/workspace" -w /workspace ghcr.io/anomalyco/opencode --model runpod-gpt/gpt-oss-120b


Bei RunPod:

Serverless > vLLM
Qwen/Qwen3-Coder-Next    (MiniMax-M3 ging nicht)
(war kein AccessToken von HuggingFace nötig)
Endpoint 2x 80 GB
-> erzeugen hat funktioniert aber 







- In your project-root add opencode.json





cd 








cd C:\@DevOps\CT-BIZTRAVEL\GenAI\Empty

docker desktop enable model-runner --tcp=12434


docker run -it --rm --network host -v "%cd%:/workspace" -w /workspace ghcr.io/anomalyco/opencode --model dmr/qwen3-coder

docker run -it --rm --add-host=host.docker.internal:host-gateway -v "%cd%:/workspace" -w /workspace ghcr.io/anomalyco/opencode --model dmr/qwen3-coder

--add-host=host.docker.internal:host-gateway    und in opencode.json baseURL: http://docker.internal
--network host                                  und in opencode.json baseURL: http://localhost:12434/v1



mit host http://localhost:12434/v1

Macht ein Model mit grösserem context-fenster
docker model package --from ai/qwen3-coder --context-size 32768 ai/qwen3-coder:32k




Neuer Versuch mit RunPod "Pod" statt "Serverless"
-------------------------------------------------

Container Image:    vllm/vllm-openai:latest

Container start command:
Qwen/Qwen3.5-35B-A3B-FP8 --host 0.0.0.0 --port 8000 --dtype bfloat16 --gpu-memory-utilization 0.95 --max-model-len 16384 --tool-call-parser hermes --enable-auto-tool-choice
                         


Container disk:     40
Volume disk:        60
Volume mount path:  /workspace
HTTP ports:         8000

-> Set overrides

-> RTX 4090
-> RTX 6000 Ada


URL für OpenCode https://[YOUR_POD_ID]-8000.proxy.runpod.net/v1


POD_ID = 7oen7d583vahde


Neuer Versuch mit RunPod "Serverless"
-------------------------------------

Deploy from a Docker image

Container Image:    vllm/vllm-openai:v0.27.1-cu129-ubuntu2404

Container start command:
Qwen/Qwen3.5-35B-A3B-FP8 --host 0.0.0.0 --port 8000 --dtype bfloat16 --quantization fp8 --gpu-memory-utilization 0.85 --max-model-len 8192 --enable-auto-tool-choice --tool-call-parser hermes --enable-prefix-caching
   
Container disc: 150 GB

Expose HTTP: 8000

Environment:
none

Queue (Default)

-> Next 

GPU 1st: 48 GB Pro
Max worker: 1
Active workers: 0
GPU Count: 1
Idle timeout: 300 Sec
Enable FlashBoot: True
Enable Execution Timeout: true
Execution Timeout: 600
Cached Model: https://huggingface.co/Qwen/Qwen3.5-35B-A3B-FP8
Allowed CUDA versions: All versions (Minimum Cuda Version: Any)
Auto scaling type: Queue delay
Queue delay: 10 sec
L40, L40S, RTX 6000 Ada, PRO 6000 MIG 48GB 

Environment:
VLLM_USE_DEEP_GEMM 0
VLLM_USE_V1 0

Deploy -> 

inland_gold_dolphin

nach "initializing"




