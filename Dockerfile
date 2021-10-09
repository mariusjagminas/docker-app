FROM node:12.18.1

WORKDIR /app

COPY ["package.json", "package-lock.json", "./"]

RUN npm install --production

COPY dist dist

COPY client client

CMD [ "node","dist/main.js" ]