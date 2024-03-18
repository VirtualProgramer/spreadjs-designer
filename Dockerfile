FROM node:20.10.0 as node-builder
WORKDIR /src
COPY . .
RUN npm install
ARG config=production
RUN npm run node:build -- --configuration=$config

FROM nginx:1.15.2-alpine
COPY --from=node-builder /src/dist /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
