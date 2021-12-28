FROM minio/mc

ENV LANG C.UTF-8

# add aws-cli and deps
RUN microdnf update --nodocs && \
        microdnf install jq --nodocs && \
        microdnf clean all

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

ENTRYPOINT [ "/bin/sh" ]

CMD [ "/run.sh" ]
