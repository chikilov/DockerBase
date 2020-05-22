# DockerBase

# Create Docker Image
git clone https://github.com/chikilov/DockerBase.git

cd DockerBase/

docker build -t dev-ubuntu-base:latest .

# Create Docker Container

docker run -ti -p 80:80 -p 3306:3306 -v /Volumes/exhdd/{PROJECT_PATH}:/home/ubuntu/apps/current dev-ubuntu-base

# Start Required Services at Container Shell

sudo chown -R mysql:mysql /var/lib/mysql /var/run/mysqld ( when start container(just once) )

sudo service mysql start ( when start container(everytimes) )

sudo service php7.3-fpm start ( when start container(everytimes) )

sudo service nginx start ( when start container(everytimes) )

# Other Notices

port binding : 80(nginx), 3306(mysql)

when mysql access using other client directly : vi /etc/mysql/mysql.conf.d/mysqld.cnf -> comment out (bind-address line) -> restart mysql service