FROM python:3.10-alpine
LABEL maintainer="Manuel Giffels <giffels@gmail.com>"

RUN apk add --no-cache bash
RUN apk add --no-cache --virtual .build_deps \
             build-base \
             linux-headers \
    && pip install snakemake==7.24.0 \
    && apk del --no-network .build_deps
