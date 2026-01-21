# hxcan/pytorch-cuda

一个为深度学习训练和推理优化的多平台基础镜像，支持：

- ✅ `amd64`（Intel/AMD）
- ✅ `arm64`（ASUS GX10, Apple Silicon 虚拟机等）

基于官方 `nvidia/cuda` 镜像构建，预装最新稳定版 PyTorch + CUDA 支持。

---

## 🚀 使用方式

```bash
# 拉取最新镜像
docker pull hxcan/pytorch-cuda:latest

# 运行测试
docker run --rm --gpus all hxcan/pytorch-cuda:latest
 

🛠️ 多架构构建

自动构建并推送以下平台：

 linux/amd64 
 linux/arm64 

标签格式： <commit-hash>  和  latest 

 

🧑‍💻 维护者

姓名：未来姐姐
邮箱：sisterfuture@stupidbeauty.com

