################################################################################
# See if this can be more specific
FROM node:lts-alpine AS prod-npm

WORKDIR /usr/src/app
COPY package*.json ./
RUN npm ci --production

################################################################################
FROM prod-npm AS dev-npm

RUN npm ci

################################################################################
FROM dev-npm AS builder

COPY . .
RUN npm run build

################################################################################
FROM dev-npm AS dev

ENV NODE_ENV development
COPY . .
CMD ["npm", "run", "dev"]

################################################################################
FROM node:lts-alpine AS prod

WORKDIR /usr/src/app
ENV NODE_ENV production
COPY --from=prod-npm /usr/src/app/node_modules ./node_modules
COPY --from=builder /usr/src/app/next.config.js ./
COPY --from=builder /usr/src/app/public ./public
COPY --from=builder /usr/src/app/.next ./.next
COPY --from=builder /usr/src/app/package.json ./package.json
CMD ["npm", "run", "start"]
