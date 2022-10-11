FROM gitpod/workspace-base:latest

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

RUN sudo add-apt-repository ppa:ondrej/php -y && \
    curl -fsSL https://deb.nodesource.com/setup_16.x | sudo bash - && \
    curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh' | sudo -E bash && \
    sudo apt-get install -y \
    php8.1-fpm php8.1-mysql php8.1-curl php8.1-gd php8.1-xml php8.1-zip php8.1-opcache php8.1-mbstring php8.1-intl php8.1-cli \
    rsync \
    symfony-cli \
    nodejs && \
    sudo wget https://github.com/FriendsOfShopware/shopware-cli/releases/download/0.1.39/shopware-cli_linux_amd64.deb && \
    sudo dpkg -i shopware-cli_linux_amd64.deb && \
    sudo rm shopware-cli_linux_amd64.deb && \
    echo "memory_limit=512M" > php.ini && \
    echo "assert.active=0" >> php.ini && \
    echo "opcache.interned_strings_buffer=20" >> php.ini && \
    echo "zend.detect_unicode=0" >> php.ini && \
    echo "realpath_cache_ttl=3600" >> php.ini && \
    sudo cp php.ini /etc/php/8.1/cli/conf.d/99-overrides.ini && \
    sudo cp php.ini /etc/php/8.1/fpm/conf.d/99-overrides.ini && \
    rm php.ini
