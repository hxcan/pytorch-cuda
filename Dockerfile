# ================================
#  PyTorch + CUDA 基础镜像
#  支持 amd64 和 arm64 架构
# ================================
FROM nvidia/cuda:13.1.0-base-ubuntu24.04

LABEL maintainer="sisterfuture@stupidbeauty.com"
LABEL org.opencontainers.image.source="https://github.com/hxcan/pytorch-cuda"
LABEL org.opencontainers.image.description="PyTorch with CUDA support for amd64 and arm64"
LABEL org.opencontainers.image.license="MIT"

# 设置非交互式安装模式
ENV DEBIAN_FRONTEND=noninteractive

# 安装系统依赖
RUN apt-get update && \
    apt-get install -y \
        python3 \
        python3-pip \
        libgl1 \
        libglib2.0-0 \
        wget \
        curl \
        tzdata \
    && rm -rf /var/lib/apt/lists/*

# 设置时区
RUN ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

# 升级 pip 等工具链
RUN pip3 install --upgrade pip setuptools wheel --break-system-packages || true

# 安装 PyTorch + cu130
RUN pip install torch==2.9.1 torchvision==0.24.1 torchaudio==2.9.1 \
    --extra-index-url https://download.pytorch.org/whl/cu130 \
    --break-system-packages

# 设置工作目录
WORKDIR /app

# 健康检查：验证 CUDA 是否可用
HEALTHCHECK CMD python3 -c "import torch; exit(0) if torch.cuda.is_available() else exit(1)" || exit 1

# 默认命令：输出版本信息
CMD ["python3", "-c", "import torch; print(f'✅ PyTorch {torch.__version__}, CUDA available: {torch.cuda.is_available()}')"]
