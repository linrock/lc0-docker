#!/bin/bash

num_gpus=$(nvidia-smi --list-gpus | wc -l)

cd /root/lc0/build/release
for gpu_id in $( seq 0 $(( $num_gpus - 1 )) ); do
  ./lc0-training-client-linux -backend-opts="cuda-fp16(gpu=$gpu_id)" -report-host &
done

wait
