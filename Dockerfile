FROM ruby:2.5-stretch

ENV LOGSTASH_GROK_PATTERNS_HOMEDIR=/logstash-grok-patterns
ENV DEBIAN_FRONTEND noninteractive

RUN gem install jls-grok minitest

RUN apt-get update && apt-get -y install git \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/* \
        && rm -rf /tmp/*

ENV LANG="en_US.UTF-8"
ENV RUBYOPT="-KU -E utf-8:utf-8"

COPY . $LOGSTASH_GROK_PATTERNS_HOMEDIR
WORKDIR $LOGSTASH_GROK_PATTERNS_HOMEDIR
RUN git submodule update --init

CMD [ "sh", "-c", "ruby test/test.rb" ]
