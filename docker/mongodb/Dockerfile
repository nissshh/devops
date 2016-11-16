# Dockerizing MongoDB: Dockerfile for building MongoDB images
# Based on ubuntu:16.04, installs MongoDB following the instructions from:
# http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/

FROM       ubuntu:16.04
MAINTAINER Nishant Sonar <nishant.sonar@synechron.com>

# Installation:
# Import MongoDB public GPG key AND create a MongoDB list file
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
RUN	echo "deb http://repo.mongodb.org/apt/ubuntu $(cat /etc/lsb-release | grep DISTRIB_CODENAME | cut -d= -f2)/mongodb-org/3.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.2.list
# Update apt-get sources AND install MongoDB,Shell,Server and Tools
RUN	apt-get update && \
	apt-get install -y --force-yes pwgen mongodb-org mongodb-org-server mongodb-org-shell mongodb-org-mongos mongodb-org-tools && \
	echo "mongodb-org hold" | dpkg --set-selections && echo "mongodb-org-server hold" | dpkg --set-selections && \
	echo "mongodb-org-shell hold" | dpkg --set-selections && \
	echo "mongodb-org-mongos hold" | dpkg --set-selections && \
	echo "mongodb-org-tools hold" | dpkg --set-selections

# Create the MongoDB data directory
RUN mkdir -p /data/db
VOLUME /data/db

# Expose port #27017 and  #28017 from the container to the host
EXPOSE 27017 28017

# Set /usr/bin/mongod as the dockerized entry-point application
ENTRYPOINT ["/usr/bin/mongod"]

#Ref https://github.com/tutumcloud/mongodb/blob/master/3.2/Dockerfile