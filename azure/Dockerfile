FROM codercom/code-server
WORKDIR /root

RUN apt-get update && apt-get install -y \
	curl \
	apt-transport-https \
	lsb-release \
	gpg \
	apt-utils \
	nano \
	jq

RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null

RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/azure-cli.list
RUN apt-get update
RUN apt-get install azure-cli

RUN apt-get autoremove
RUN apt-get autoclean

RUN locale-gen en_US.UTF-8
# We unfortunately cannot use update-locale because docker will not use the env variables
# configured in /etc/default/locale so we need to set it manually.
ENV LANG=en_US.UTF-8
EXPOSE 8443
#ENTRYPOINT ["code-server"]
CMD ["code-server", "--allow-http", "--no-auth"]
