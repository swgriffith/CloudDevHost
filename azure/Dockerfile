FROM node:8.15.0

# Install VS Code's deps. These are the only two it seems we need.
RUN apt-get update && apt-get install -y \
	libxkbfile-dev \
	libsecret-1-dev \
	git

# Ensure latest yarn.
RUN npm install -g yarn@1.13

WORKDIR /src

RUN git clone https://github.com/codercom/code-server.git
WORKDIR /src/code-server

# In the future, we can use https://github.com/yarnpkg/rfcs/pull/53 to make yarn use the node_modules
# directly which should be fast as it is slow because it populates its own cache every time.
RUN yarn && yarn task build:server:binary

# We deploy with ubuntu so that devs have a familiar environment.
FROM ubuntu:18.10
WORKDIR /root/project
COPY --from=0 /src/code-server/packages/server/cli-linux-x64 /usr/local/bin/code-server
EXPOSE 8443

#Install all tools
RUN apt-get update && apt-get install -y \
	openssl \
	net-tools \
	git \
	locales \
	curl \
	apt-transport-https \
	lsb-release \
	gpg \
	apt-utils \
	nano \
	jq

#Install the Azure CLI
RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/azure-cli.list
RUN apt-get update
RUN apt-get install azure-cli

#Clean up
RUN apt-get autoremove
RUN apt-get autoclean

#Set up password environment variable and execution script
ENV PASSWORD letmein
ADD startcoder.sh /root/startcoder.sh
RUN chmod +x /root/startcoder.sh

RUN locale-gen en_US.UTF-8
# We unfortunately cannot use update-locale because docker will not use the env variables
# configured in /etc/default/locale so we need to set it manually.
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8 
CMD ["/bin/bash", "/root/startcoder.sh"]
