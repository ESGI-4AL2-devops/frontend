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


FROM nginx:1.23

WORKDIR /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /build/dist ./

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
