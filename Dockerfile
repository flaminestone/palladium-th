FROM ruby:2.4.1
ENV JWT_SECRET=someawesomesecret
ENV JWT_ISSUER=someawesomesecret
RUN mkdir /palladium-api
WORKDIR /palladium-api
ADD . /palladium-api
RUN bundle install --without test development