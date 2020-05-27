FROM alpine
COPY script.sh /root
RUN chmod +x /root/script.sh
RUN apk add curl
ENTRYPOINT /root/script.sh