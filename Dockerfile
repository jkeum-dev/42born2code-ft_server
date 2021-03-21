FROM	debian:buster

LABEL	maintainer="jkeum@student.42seoul.kr"

RUN		apt-get update && apt-get install -y \
		nginx \
		openssl \
		vim \
		php7.3-fpm \
		mariadb-server \
		php-mysql \
		php-mbstring \
		wget

COPY	./srcs/run.sh ./
COPY	./srcs/default ./
COPY	./srcs/wp-config.php ./
COPY	./srcs/config.inc.php ./

EXPOSE	80 443

CMD		bash run.sh
