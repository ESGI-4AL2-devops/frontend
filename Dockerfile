FROM node:18.11 as build

# in Debian, create a system group (`-r`) + add "admin1" to it
# -m: Create the user's home directory if it doesn't exist.
# -r: Create a system user.
# -g admingroup: Assign the user to the "admingroup" group.
RUN groupadd -r admingroup && useradd -m -r -g admingroup admin1
RUN mkdir /build
WORKDIR /build
COPY ./package*.json ./
RUN chown -R admin1:admingroup /build

USER admin1
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

USER admin1
RUN npm run build


FROM nginx:1.23

RUN groupadd -r admingroup && useradd -m -r -g admingroup admin1
RUN usermod -a -G nginx admin1
WORKDIR /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /build/dist ./
RUN chown -R admin1:admingroup /usr/share/nginx/html

#USER admin1
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
