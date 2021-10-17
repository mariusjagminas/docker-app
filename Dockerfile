FROM node:12.18.1

WORKDIR /app

COPY ["server/package.json", "server/package-lock.json", "./"]

RUN npm install --production

COPY server/dist dist

COPY client/build client

CMD [ "node","dist/main.js" ]