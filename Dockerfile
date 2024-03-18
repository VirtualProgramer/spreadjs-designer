FROM node:12.14.1-alpine3.11 AS node-builder
WORKDIR /src
COPY . .
RUN npm install
ARG config
RUN npm run build --configuration=$config

FROM nginx:1.15.2-alpine
COPY --from=node-builder /src/dist /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
