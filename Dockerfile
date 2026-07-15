
# 使用 Python 3.11 基础镜像
FROM docker.io/python:3.11-slim

# 设置工作目录
WORKDIR /app

# 复制依赖文件
COPY requirements.txt .

# 安装依赖
RUN pip install --no-cache-dir -r requirements.txt

# 复制应用代码
COPY app.py .

# 创建非 root 用户（OpenShift 安全要求）
RUN useradd -m -u 1001 appuser && chown -R appuser:appuser /app
USER 1001

# 暴露端口
EXPOSE 8080

# 启动应用
CMD ["python", "app.py"]
