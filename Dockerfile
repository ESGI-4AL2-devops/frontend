FROM node:18.0

RUN mkdir /app
WORKDIR /app
COPY ./package*.json ./
RUN npm ci
COPY . .

CMD ["npm", "run", "dev"]