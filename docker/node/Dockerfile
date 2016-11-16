FROM node:argon
EXPOSE 8080

# Create app directory for configuring app required when deploying 
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
COPY /workspace/node/app
COPY package.json /usr/src/app/
RUN npm installcat 

# Bundle app source
COPY . /usr/src/app
#CMD [ "npm", "start" ]