FROM node:20-slim

# 安装运行所需的系统依赖和证书（koffi 加载 .so 需要 glibc，debian-slim 是最稳妥的选择）
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# 先复制 package.json 安装依赖，充分利用 Docker 缓存
COPY package*.json ./
RUN npm install --production

# 复制代码
COPY . .

# 暴露端口，默认 3000，平台可通过 PORT 环境变量动态注入
ENV PORT=3000
EXPOSE 3000

CMD ["node", "index.js"]
