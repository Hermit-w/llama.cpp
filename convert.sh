#!/bin/bash

python convert_hf_to_gguf.py \
    --outfile "~/models/gguf/pi0.gguf" \
    --outtype "bf16" \
    "/export/home/lanliwei.1/models/lerobot/pi0_libero_finetuned"