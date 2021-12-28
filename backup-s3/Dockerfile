FROM minio/mc

ENV LANG C.UTF-8

# add aws-cli and deps
RUN apk -v --update --no-cache add py-pip
RUN apk add jq

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
