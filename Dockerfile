# Build construida em cima do alpine por ser mais leve que Debian e Ubuntu
FROM alpine:3.7

# Instalação de nginx e pacotes necessarios
RUN apk --update add --no-cache \
    nginx \
    curl \
    supervisor \
    php7 \
    php7-ctype \
    php7-curl \
    php7-dom \
    php7-fpm \
    php7-json \
    php7-mbstring \
    php7-mcrypt \
    php7-opcache \
    php7-openssl \
    php7-pdo \
    php7-pdo_mysql \
    php7-pdo_pgsql \
    php7-pdo_sqlite \
    php7-phar \
    php7-session \
    php7-tokenizer \
    php7-xml

# Limpar o cache das instalaçoes (Recomendável)
RUN rm -rf /var/cache/apk/*

# Instalar composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Configurando o nginx e supervisor
# Copiar arquivo de configurações para dentro do container
COPY conf/nginx/nginx.conf /etc/nginx/nginx.conf
COPY conf/supervisor/supervisord.conf /etc/supervisord.conf

# Criando diretorio onde ficará a aplicação
RUN mkdir -p app/

# Definir o diretorio app como diretorio de trabalho
WORKDIR /app

# Dando permissões para a pasta do projeto
RUN chmod -R 755 /app

# Expor as portas
EXPOSE 80 443

# Start
CMD ["supervisord", "-c", "/etc/supervisord.conf"]