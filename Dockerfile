FROM node:lts-alpine as build-stage

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build


# Stage 2 - the production environment
FROM nginx:stable-alpine
WORKDIR /usr/share/nginx
ADD nginx.conf /etc/nginx/nginx.conf 

COPY --from=build-stage /app/build /usr/share/nginx/html

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]

