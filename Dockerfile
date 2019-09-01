# two phases build
# build phase
FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# /app/build has everything we want to serve
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# don't have to manually run command to start nginx,
# the container will automatically started
