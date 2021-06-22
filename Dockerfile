FROM node:alpine
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
# for AWS Elasticbeanstlk we have to instruct the Elasticbeanstlk (docker) container
# to expose the port. Elasticbeanstlk searches this file to find the ports to expose!
EXPOSE 80
COPY --from=0 /app/build /usr/share/nginx/html
# No need to define a starting CMD [""] as the container will start nginx itself
