FROM python:3.8-alpine as build
RUN apk update && apk upgrade && pip install -U pip && \
	apk add --update alpine-sdk make gcc python3-dev libffi-dev openssl-dev git \
	&& rm -rf /var/cache/apk/*
RUN pip --no-cache-dir install requests jwcrypto GitPython

FROM python:3.8-alpine
RUN apk update && apk upgrade && \
	apk add --update git \
	&& rm -rf /var/cache/apk/*
COPY --from=build /usr/local/share /usr/local/share
COPY --from=build /usr/local/lib /usr/local/lib