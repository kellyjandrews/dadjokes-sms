FROM node:11.8.0-alpine as dev-stage

MAINTAINER Kelly J Andrews <kelly@kellyjandrews.com>

WORKDIR /usr/src

COPY package.json .

RUN npm install --quiet

ENV PATH /usr/src/node_modules/.bin:$PATH

COPY . .

EXPOSE 3000

CMD ["npm", "start"]

# FROM node:11.8.0-alpine as build-stage
#
# WORKDIR /usr/src
# COPY --from=dev-stage /usr/src /usr/src
# RUN npm run build
#
# FROM nginx:1.15
# COPY --from=build-stage /usr/src/build/ /usr/share/nginx/html
# COPY --from=build-stage /usr/src/nginx.conf /etc/nginx/conf.d/default.conf
