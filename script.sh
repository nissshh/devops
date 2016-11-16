#Script file that would be run during provisioning for the instances

# create project specifics soft links to share code

echo Message=====>install docker-engine
echo Message=====> let's update the package database:
apt-get update
apt-get install apt-transport-https ca-certificates
echo Message=====> Now let's install Docker. Add the GPG key for the official Docker repository to the system:
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo Message=====> Add the Docker repository to APT sources
apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'
echo Message=====> Update the package database with the Docker packages from the newly added repo:
apt-get update
echo Message=====> For Ubuntu Trusty, Wily, and Xenial, it’s recommended to install the linux-image-extra-* kernel packages. The linux-image-extra-* packages allows you use the aufs storage driver.
apt-get install linux-image-extra-$(uname -r) linux-image-extra-virtual
echo Message=====> Make sure you are about to install from the Docker repo instead of the default Ubuntu 16.04 repo:
apt-cache policy docker-engine
apt-get update
echo Message=====> Finally, install Docker:
apt-get install -y docker-engine
echo Message=====> Start the docker daemon.
service docker start
echo Message=====> Verify docker is installed correctly.
docker run hello-world
echo Message=====> Create the docker group.
groupadd docker
echo Message=====> Add your user to docker group.
usermod -aG docker $USER
echo Message=====> Install docker compose
curl -L https://github.com/docker/compose/releases/download/1.8.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
echo Message=====> Apply executable permissions to the binary:
chmod +x /usr/local/bin/docker-compose
echo Message=====> Test installation
docker-compose --version
echo Message=====> Create Mongo DB installation folder
mkdir /opt/mongodb/
echo Message=====> Get mongodob docker file
cp /vagrant/docker/mongodb/Dockerfile /opt/mongodb/Dockerfile
cd /opt/mongodb/
echo Message=====> build mongodb Image
docker build -t mylocal/mongodb .
echo Message=====> Start using MongoDB Image
#Usage: docker run --name <name for container> -d <user-name>/<repository>
docker run -p 27017:27017 --name mongo_instance_001 -d mylocal/mongodb:latest
#echo Message=====> Test Mongo check version 
#sudo service mongod start
echo Message=====> Create Node JS installation folder
mkdir /opt/node/
echo Message=====> Get node JS docker file
cp /vagrant/docker/node/Dockerfile /opt/node/Dockerfile
cd /opt/node/
echo Message=====> build node js Image
docker build -t mylocal/nodejs .
echo Message=====> Start using Node JS Image
docker run --name nodejs_instance_001 -d mylocal/nodejs:latest
echo Message=====> Test Node & Npm check version 
node --version
npm --version
