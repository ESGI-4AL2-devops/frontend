FROM node:18.0

# create a system group (`-r`) + add "admin1" to it
# -m: Create the user's home directory if it doesn't exist.
# -r: Create a system user.
# -g admingroup: Assign the user to the "admingroup" group.
RUN groupadd -r admingroup && useradd -m -r -g admingroup admin1
RUN mkdir /app
WORKDIR /app
COPY ./package*.json ./

USER admin1
RUN npm ci --ignore-scripts

USER root
COPY src/ ./src/
COPY public/ ./public/
RUN chown -R admin1:admingroup /app

USER admin1
CMD ["npm", "run", "dev"]