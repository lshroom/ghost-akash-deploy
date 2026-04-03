FROM node:20-alpine
RUN apk add --no-cache python3 py3-pip make g++ git curl bash && npm install -g pm2
WORKDIR /app
# polly-cli deps
COPY polly-cli/package.json polly-cli/package-lock.json ./polly-cli/
RUN cd polly-cli && npm install --production
# source
COPY polly-cli/ ./polly-cli/
COPY ghost-static-server.js ghost_v2.html ecosystem.akash.config.cjs ./
COPY akash-entrypoint.sh /akash-entrypoint.sh
RUN chmod +x /akash-entrypoint.sh
ENV NODE_ENV=production
ENTRYPOINT ["/akash-entrypoint.sh"]
