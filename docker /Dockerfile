FROM pytorch/pytorch:2.6.0-cuda12.4-cudnn9-devel

WORKDIR /workspace/Infinite-World

RUN apt-get update && apt-get install -y \
    ffmpeg git wget

RUN pip install --upgrade pip setuptools wheel packaging psutil
# RUN pip install torch==2.6.0 torchvision==0.21.0 --index-url https://download.pytorch.org/whl/cu124


# Copy requirements first for better layer caching.
# flash_attn compiles from source, so we pass MAX_JOBS to use all available cores.
COPY requirements.txt .
RUN pip install flash_attn==2.7.4.post1 --no-build-isolation
RUN pip install -r requirements.txt

# Copy the rest of the project
# COPY . .

CMD ["bash"]
