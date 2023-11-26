FROM node:18.0

# create a system group (`-r`) + add "admin1" to it
# -m: Create the user's home directory if it doesn't exist.
# -r: Create a system user.
# -g admingroup: Assign the user to the "admingroup" group.
RUN groupadd -r admingroup && useradd -m -r -g admingroup admin1
RUN mkdir /app
WORKDIR /app
COPY ./package*.json ./
RUN chown -R admin1:admingroup /app

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
RUN chown -R admin1:admingroup /app

USER admin1
CMD ["npm", "run", "dev"]