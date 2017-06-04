FROM ruby:2.4.1-alpine
RUN adduser -S app
WORKDIR /app

RUN apk add --no-cache --virtual .build-dependencies \
  build-base

COPY Gemfile* ./

ARG RACK_ENV=production

RUN if [ "$RACK_ENV" = "production" ]; then \
  bundle --without "development test"; \
else \
  bundle --with "development test"; \
fi \
&& apk del .build-dependencies

COPY . .

USER app

CMD ["/usr/local/bin/bundle","exec", "rackup", "-s", "Puma", "-o", "0.0.0.0", "-p", "8080"]
