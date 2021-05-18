FROM node:12.19-slim

ENV USER=evening

# install python and make
RUN apt-get update && \
	apt-get install -y python3 build-essential && \
	apt-get purge -y --auto-remove
	
# create evening user
RUN groupadd -r ${USER} && \
	useradd --create-home --home /home/evening -r -g ${USER} ${USER}
	
# set up volume and user
USER ${USER}
WORKDIR /home/evening

COPY package*.json ./
RUN npm install
VOLUME [ "/home/evening" ]

COPY . .

ENTRYPOINT [ "node", "index.js" ]
