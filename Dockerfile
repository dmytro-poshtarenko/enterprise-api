FROM node:20.17.0
WORKDIR /app
COPY package*.json ./
RUN npm ci -q
COPY . .
EXPOSE 3000
CMD ["npm", "run", "prod"]
