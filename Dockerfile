FROM litestream/litestream AS litestream

FROM codeberg.org/readeck/readeck:latest AS readeck

FROM debian:bookworm-slim

RUN apt-get update \
        && apt-get install -y --no-install-recommends ca-certificates

RUN update-ca-certificates

COPY --from=litestream /usr/local/bin/litestream /usr/local/bin/litestream

COPY --from=readeck /bin/readeck /usr/local/bin/readeck

COPY litestream.yml /etc/litestream.yml

CMD [ "litestream", "replicate", "-exec", "readeck serve" ]
