wget http://download.sonatype.com/nexus/3/latest-unix.tar.gz
docker-compose build
docker-compose up -d
http://xx.xx.xx.xx:8081/nexus
login admin 
pass /usr/local/sonatype-work/nexus3/admin.password
http://localhost:8081/#admin/security/realms  => active Dcoker Bearer Token Realm

docker push nexus 
1 docker tag 53df61775e88 localhost:XXXX/bubuntu:20.04
2 docker login localhost:XXXX
3 docker push localhost:XXXX/bubuntu:20.04
