if [ ! -e server.key ]; then
    # https://help.ubuntu.com/lts/serverguide/certificates-and-security.html.en#creating-a-self-signed-certificate
    openssl genrsa -des3 -out server.key 2048
    openssl rsa -in server.key -out server.key.insecure
    mv server.key server.key.secure
    mv server.key.insecure server.key
    openssl req -new -key server.key -out server.csr
    openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
fi
