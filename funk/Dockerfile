FROM ruby:2.4.1-alpine
RUN apk add --no-cache --virtual .build-dependencies \
  build-base

WORKDIR /app

COPY Gemfile* ./

ARG RACK_ENV=production
RUN if [ "$RACK_ENV" = "production" ]; then \
  bundle --without "development test"; \
else \
  bundle --with "development test"; \
fi \
&& apk del .build-dependencies

COPY . .

CMD ["/usr/local/bin/bundle","exec", "rackup", "-s", "Puma", "-o", "0.0.0.0", "-p", "8080"]
