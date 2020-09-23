FROM alpine:3

RUN apk add --no-cache curl unzip && curl -L https://github.com/storj/gateway/releases/latest/download/gateway_linux_amd64.zip -O && unzip gateway_linux_amd64.zip && apk del curl unzip
RUN chmod 755 gateway
RUN mv gateway /usr/local/bin/gateway

EXPOSE 7777

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
