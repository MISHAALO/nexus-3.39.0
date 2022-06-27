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



Nexus ssl сертификат

keytool -genkeypair -keystore keystore.jks -storepass password -keypass password -alias jetty -keyalg RSA -keysize 2048 -validity 5000 -dname "CN=*.${NEXUS_DOMAIN}, OU=Example, O=Sonatype, L=не указано, ST=не указано, C=US" -ext "SAN=DNS:${NEXUS_DOMAIN},IP:${NEXUS_IP_ADDRESS}" -ext "BC=ca:true"

    Замените ${NEXUS_DOMAIN} DNS-именем вашего хоста Nexus. Имя хоста должно разрешаться от хоста, на котором работает демон Docker.
    Замените ${NEXUS_IP_ADDRESS} на IP-адрес вашего хоста Nexus. IP-адрес должен маршрутизироваться к Nexus с хоста, на котором работает демон Docker.

Созданный файл положить /d01/nexus-3.39.0-01/etc/ssl/keystore.jks


Отредактировать файл

/d01/nexus/etc/jetty/jetty-https.xml)

<Set name="KeyStorePath"><Property name="ssl.etc"/>/keystore.jks</Set>
<Set name="KeyStorePassword">изменить</Set>
<Set name="KeyManagerPassword">изменить</Set> 
<Set name="TrustStorePassword">изменить</Set>


/d01/sonatype-work/nexus3/etc/nexus.properties

nexus-args=${jetty.etc}/jetty.xml,${jetty.etc}/jetty-http.xml,${jetty.etc}/jetty-https.xml,${jetty.etc}/jetty-requestlog.xml

application-port-ssl=9999 - заменить на нужный




экспортировать ключ

keytool -export -alias jetty -keystore keystore.jks -rfc -file  ca.crt


Создать директорию

sudo mkdir /etc/docker/certs.d/доменное_имя:порт

Положить в директорию

cp ca.crt  /etc/docker/certs.d/доменное_имя:порт

Перезапустить нексус

Проверка docker login доменное_имя:порт -u пользователь -p пароль
