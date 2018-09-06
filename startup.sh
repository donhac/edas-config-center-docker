#/bin/bash
cd `dirname $0`

img_output="deep/edas-config-center" 
SERVER_IP=192.168.31.100

docker build -t $img_output .

docker rm -f config-center &>/dev/null

docker run -d \
    -p 8080:8080 \
    -p 9600:9600 \
    --name config-center \
    $img_output \
    java \
        -Djava.security.egd=file:/dev/./urandom \
        -Daddress.server.ip=$SERVER_IP  \
        -jar /home/edas-config-center.jar