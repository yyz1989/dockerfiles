FROM debian:wheezy
# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added

RUN groupadd -r redis && useradd -r -g redis redis
ENV REDIS_VERSION 2.8.9
ENV REDIS_DOWNLOAD_URL http://download.redis.io/releases/redis-2.8.9.tar.gz
ENV REDIS_DOWNLOAD_SHA1 003ccdc175816e0a751919cf508f1318e54aac1e

RUN buildDeps='gcc libc6-dev make'; \
set -x; \
apt-get update && apt-get install -y $buildDeps curl openssh-server --no-install-recommends \
&& rm -rf /var/lib/apt/lists/* \
&& mkdir -p /usr/src/redis \
&& curl -sSL "$REDIS_DOWNLOAD_URL" -o redis.tar.gz \
&& echo "$REDIS_DOWNLOAD_SHA1 *redis.tar.gz" | sha1sum -c - \
&& tar -xzf redis.tar.gz -C /usr/src/redis --strip-components=1 \
&& rm redis.tar.gz \
&& make -C /usr/src/redis \
&& make -C /usr/src/redis install \
&& rm -r /usr/src/redis \
&& apt-get purge -y $buildDeps curl \
&& apt-get autoremove -y

RUN mkdir /var/run/sshd
RUN echo 'root:root' |chpasswd

RUN mkdir /data && chown redis:redis /data
VOLUME /data
WORKDIR /data
USER redis

EXPOSE 6379 22
CMD [ "redis-server" ]
