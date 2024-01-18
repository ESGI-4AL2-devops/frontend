FROM node:18.11 as build

RUN mkdir /build
WORKDIR /build
COPY ./package*.json ./

RUN npm ci --ignore-scripts

USER root
COPY __tests__ ./__tests__
COPY cypress ./cypress
COPY env/ ./env/
COPY public/ ./public/
COPY src/ ./src/
COPY .env ./
COPY cypress.config.ts ./
COPY jest.config.cjs ./
COPY index.html ./
COPY tsconfig.json ./
COPY tsconfig.node.json ./
COPY vite.config.ts ./

RUN npm run build

# ---

FROM nginx:1.23

WORKDIR /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /build/dist ./


RUN groupadd -r admingroup && useradd -m -r -g admingroup admin1
RUN usermod -aG nginx admin1
USER admin1
WORKDIR /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /build/dist ./
RUN chown -R admin1:admingroup /usr/share/nginx/html

USER root

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
