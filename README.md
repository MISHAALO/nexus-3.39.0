wget http://download.sonatype.com/nexus/3/latest-unix.tar.gz
docker-compose build
docker-compose up -d
http://xx.xx.xx.xx:8081/nexus
login admin 
pass /usr/local/sonatype-work/nexus3/admin.password
