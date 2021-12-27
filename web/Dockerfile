################################################################################
FROM node:lts-alpine AS prod-depencencies

WORKDIR /usr/src/app
COPY package*.json ./
RUN npm ci --production

################################################################################
FROM prod-depencencies AS all-dependencies

RUN npm ci

################################################################################
FROM all-dependencies AS builder

COPY . .
RUN npm run build

################################################################################
FROM node:lts-alpine AS prod

WORKDIR /usr/src/app
ENV NODE_ENV production
COPY --from=prod-depencencies /usr/src/app/node_modules ./node_modules
COPY --from=builder /usr/src/app/next.config.js ./
COPY --from=builder /usr/src/app/public ./public
COPY --from=builder /usr/src/app/.next ./.next
COPY --from=builder /usr/src/app/package.json ./package.json
ENTRYPOINT ["npm"]
CMD ["run", "start"]

################################################################################
FROM all-dependencies AS dev

ENV NODE_ENV development
COPY . .
ENTRYPOINT ["/usr/src/app/.docker/docker-nextjs-entrypoint.sh"]
