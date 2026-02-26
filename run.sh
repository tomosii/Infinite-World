#!/bin/bash
# Run Infinite-World inference inside Docker.
# Usage: bash run.sh [num_gpus]
# Example: bash run.sh 1    (single GPU)
# Example: bash run.sh 4    (4 GPUs via torchrun)
#
# Mounts:
#   ./checkpoints  -> /workspace/Infinite-World/checkpoints  (read-only)
#   ./outputs      -> /workspace/Infinite-World/outputs       (read-write)
#   ./prompts      -> /workspace/Infinite-World/prompts       (read-only)
#
# Override image: IMAGE_NAME=myrepo/infworld IMAGE_TAG=v1 bash run.sh
set -e

NUM_GPUS=${1:-1}
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
IMAGE_NAME=${IMAGE_NAME:-infworld}
IMAGE_TAG=${IMAGE_TAG:-latest}

mkdir -p "$SCRIPT_DIR/outputs"

if [ "$NUM_GPUS" -eq 1 ]; then
    GPU_FLAGS="--gpus device=0"
else
    GPU_FLAGS="--gpus all"
fi

echo "=============================================="
echo "Infinite World - Inference"
echo "Image   : ${IMAGE_NAME}:${IMAGE_TAG}"
echo "GPUs    : ${NUM_GPUS}"
echo "Outputs : ${SCRIPT_DIR}/outputs"
echo "=============================================="


docker run --rm -it \
    $GPU_FLAGS \
    --shm-size=16g \
    -v "$SCRIPT_DIR:/workspace/Infinite-World" \
    -e WANDB_API_KEY=$WANDB_API_KEY \
    "${IMAGE_NAME}:${IMAGE_TAG}"




# docker run --rm \
#     $GPU_FLAGS \
#     --shm-size=16g \
#     -v "$SCRIPT_DIR/checkpoints:/workspace/Infinite-World/checkpoints:ro" \
#     -v "$SCRIPT_DIR/outputs:/workspace/Infinite-World/outputs" \
#     -v "$SCRIPT_DIR/prompts:/workspace/Infinite-World/prompts:ro" \
#     "${IMAGE_NAME}:${IMAGE_TAG}" \
#     bash -c "
#         set -e
#         cd /workspace/Infinite-World
#         if [ \"${NUM_GPUS}\" -eq 1 ]; then
#             python scripts/infworld_inference.py
#         else
#             MASTER_PORT=\${MASTER_PORT:-29400}
#             echo \"MASTER_PORT: \$MASTER_PORT\"
#             torchrun --nnodes=1 --nproc_per_node=${NUM_GPUS} \
#                 --rdzv_id=100 --rdzv_backend=c10d \
#                 --rdzv_endpoint=localhost:\$MASTER_PORT \
#                 scripts/infworld_inference.py
#         fi
#     "



# docker run -t -d --rm \
#     --gpus all \
#     -v ~/:/workspace \
#     -e WANDB_API_KEY=$WANDB_API_KEY \
#     -e MUJOCO_GL=egl \
#     --name $CONTAINER_NAME $IMAGE_NAME
