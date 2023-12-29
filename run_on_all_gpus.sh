#!/bin/bash

cd /root/lc0/build/release
for gpu_id in $(seq 0 $(( $(nvidia-smi --list-gpus | wc -l) - 1 ))); do
  ./lc0-training-client-linux \
    -backend-opts="cuda-fp16(gpu=$gpu_id)" \
    -report-host
done
