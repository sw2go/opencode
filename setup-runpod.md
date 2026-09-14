# Setup RunPod Template



Template name ```AAC-llama.cpp-server-cuda-Qwen3.8-27B-UD-Q4_K_XL```

Template type ```Pods```

Compute type  ```NVIDIA GPU```

Container image
Tagged ```ghcr.io/ggml-org/llama.cpp:server-cuda```
Pinned ```ghcr.io/ggml-org/llama.cpp@sha256:0d9738b203c12d96c1157b76482d5c7afa95fd28b2031b0bff912bd457791819```

To find the version to pin:
- go to https://github.com/ggml-org/llama.cpp/pkgs/container/llama.cpp/versions?filters%5Bversion_type%5D=tagged
- find the first row with the tag: server-cuda
- copy the digest i.e. sha256:0d9738b203c12d96c1157b76482d5c7afa95fd28b2031b0bff912bd457791819

Container start command
```
{"cmd":["set -e\n: \"${MODEL_DIR:=/workspace/models}\"\n: \"${MODEL_URL:=}\"\nLOG=/workspace/init.log\nlog() { echo \"[init] $*\"; echo \"[init] $*\" \u003e\u003e \"$LOG\"; }\n\nif [ -z \"$MODEL_URL\" ]; then\n  log \"MODEL_URL is not set - starting llama-server with LLAMA_ARG_MODEL=${LLAMA_ARG_MODEL:-unset}\"\n  exec /app/llama-server\nfi\n\n: \"${MODEL_FILE:=$(basename \"${MODEL_URL%%\\?*}\")}\"\nF=\"$MODEL_DIR/$MODEL_FILE\"\nexport LLAMA_ARG_MODEL=\"$F\"\nmkdir -p \"$MODEL_DIR\"\n\nTOTAL=$(curl -fsSLI \"$MODEL_URL\" | tr -d '\\r' | awk 'tolower($1)==\"content-length:\"{v=$2} END{print v+0}') || TOTAL=0\n\nif [ -f \"$F\" ]; then\n  HAVE=$(stat -c %s \"$F\")\n  if [ \"$TOTAL\" -gt 0 ] \u0026\u0026 [ \"$HAVE\" -ne \"$TOTAL\" ]; then\n    log \"size mismatch for $MODEL_FILE: have $((HAVE/1048576)) MiB, expected $((TOTAL/1048576)) MiB\"\n    log \"the cached file does not match MODEL_URL - re-downloading\"\n    rm -f \"$F\"\n  else\n    log \"model present: $MODEL_FILE ($((HAVE/1048576)) MiB)\"\n  fi\nfi\n\nif [ ! -f \"$F\" ]; then\n  if [ \"$TOTAL\" -gt 0 ]; then\n    log \"downloading $MODEL_FILE - $((TOTAL/1048576)) MiB\"\n  else\n    log \"downloading $MODEL_FILE - size unknown, progress shown as MiB\"\n  fi\n  log \"one-time cost; cached on the volume at $MODEL_DIR\"\n  curl -fSL -C - --retry 10 --retry-delay 5 --retry-all-errors -s -o \"$F.part\" \"$MODEL_URL\" \u0026\n  P=$!\n  while kill -0 $P 2\u003e/dev/null; do\n    S=$(stat -c %s \"$F.part\" 2\u003e/dev/null || echo 0)\n    if [ \"$TOTAL\" -gt 0 ]; then\n      log \"$((S/1048576)) / $((TOTAL/1048576)) MiB ($((S*100/TOTAL))%)\"\n    else\n      log \"$((S/1048576)) MiB downloaded\"\n    fi\n    sleep 20\n  done\n  if wait $P; then\n    mv \"$F.part\" \"$F\"\n    log \"download complete: $(($(stat -c %s \"$F\")/1048576)) MiB\"\n  else\n    log \"download failed - container restarts and resumes from $(stat -c %s \"$F.part\" 2\u003e/dev/null || echo 0) bytes\"\n    exit 1\n  fi\nfi\nlog \"disk: $(df -h \"$MODEL_DIR\" | tail -1)\"\nlog \"starting llama-server with $F\"\nexec /app/llama-server\n"],"entrypoint":["/bin/sh","-c"]}
```

Container disk     ```20 GB```

Persistent storage ```30GB```

Persistent storage mount path ```/workspace```

Networking configuration
Label ```8000``` Number ```8000```

Environment variables
```
LLAMA_ARG_HOST 0.0.0.0
LLAMA_ARG_N_GPU_LAYERS 999
MODEL_URL https://huggingface.co/unsloth/Qwen3.8-27B-GGUF/resolve/main/Qwen3.8-27B-UD-Q4_K_XL.gguf
LLAMA_ARG_CACHE_TYPE_K q8_0
LLAMA_ARG_CTX_SIZE 196608
LLAMA_ARG_FLASH_ATTN on
LLAMA_ARG_N_PARALLEL 1
LLAMA_ARG_PORT 8000
MODEL_DIR /workspace/models
MODEL_FILE Qwen3.8-27B-UD-Q4_K_XL.gguf
LLAMA_ARG_CACHE_TYPE_V q8_0
LLAMA_ARG_ALIAS Qwen3.8-27B-UD-Q4_K_XL
LLAMA_API_KEY {{ RUNPOD_SECRET_MY_PODS_API_KEY }}
```