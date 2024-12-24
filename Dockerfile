FROM node:20-alpine AS base
WORKDIR /app
COPY package*.json ./
RUN apk add --no-cache python3 make g++ && ln -sf python3 /usr/bin/pythonx
RUN npm install -g pnpm
COPY . .
EXPOSE 4001
ENV PORT 4001

FROM base AS builder
WORKDIR /app
ENV NEXT_TELEMETRY_DISABLED 1
RUN pnpm run build

FROM base AS dev
WORKDIR /app
ENV NODE_ENV=development

RUN pnpm i
CMD pnpm run dev
