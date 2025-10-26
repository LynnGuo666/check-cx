FROM node:22.21-alpine

# Install required system packages
RUN apk add --no-cache bash

# Install global npm tooling
RUN npm install -g pnpm \
    @anthropic-ai/claude-code@2.0.22 \
    @openai/codex@0.45.0

# Copy application source
COPY . /app

WORKDIR /app

# Ensure scripts are executable and install dependencies
RUN chmod +x install.sh start-prod.sh && \
    ./install.sh && \
    mkdir -p /root/.claude/projects && \
    mkdir -p config

VOLUME ["/app/config"]

EXPOSE 30001

CMD ["./start-prod.sh"]
