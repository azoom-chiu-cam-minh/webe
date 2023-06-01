FROM node:18.16.0 as development 

WORKDIR /user/src/app 

COPY package*.json ./

RUN npm install

COPY . .
 
RUN npm run build 


FROM node:18.16.0 as production 

ARG NODE_ENV=production

ENV NODE_ENV=${NODE_ENV}

WORKDIR /user/src/app 

COPY package*.json ./

RUN npm install 

COPY --from=development /user/src/app/dist ./dist
COPY --from=development /user/src/app/package.json .
COPY --from=development /user/src/app/.env .

CMD [ "node", "dist/main" ]

