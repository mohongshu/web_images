FROM centos:7
MAINTAINER MO

#安装epel-release
RUN yum install epel-release -y
#安装supervisor
RUN yum install python-setuptools -y
RUN easy_install supervisor
#安装nginx
RUN yum install nginx -y
#php和php-fpm
RUN yum install php php-fpm -y
RUN yum install php-mysql -y
RUN yum install ntpdate -y
#设置时区
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo 'Asia/Shanghai' > /etc/timezone
#通讯端口
EXPOSE 80

#常驻进程supervisor的配置
ADD ./supervisord.conf /etc/supervisord.conf

#配置修改
ADD ./php_conf/php.ini /etc/php.ini
ADD ./nginx_conf/nginx /etc/nginx
#程序
RUN mkdir /web
#容器启动时执行
CMD supervisord -c /etc/supervisord.conf
