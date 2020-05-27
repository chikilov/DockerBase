# DockerBase

# Create Docker Image
git clone https://github.com/chikilov/DockerBase.git

cd DockerBase/

docker build -t dev-ubuntu-base:latest .

# Create Docker Container

docker run -ti -p 80:80 -p 3306:3306 -v {PROJECT_PATH}:/home/ubuntu/apps/current dev-ubuntu-base

# Start Required Services at Container Shell

sudo service mysql start ( when start container(everytimes) )

sudo service php7.3-fpm start ( when start container(everytimes) )

sudo service nginx start ( when start container(everytimes) )

# Other Notices

port binding : 80(nginx), 3306(mysql)
