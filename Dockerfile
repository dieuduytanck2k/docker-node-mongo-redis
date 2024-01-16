FROM node:12.18-alpine

WORKDIR /app

RUN npm install -g pm2

COPY test.js .

COPY ["package.json", "package-lock.json*", "./"]

RUN npm install --production --silent

COPY . .

RUN addgroup -g 1200 appgroup

RUN adduser -D -u 1200 appuser -G appgroup

RUN chown -R appuser:appgroup /app

USER appuser

CMD ["pm2-runtime", "ecosystem.config.js", "--env", "production"]
