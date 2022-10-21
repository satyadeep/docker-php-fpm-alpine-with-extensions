#!/bin/sh
function installextension() {
    echo 'Installing extension '$3 && \
    # touch /tmp/testfile && \
    if [ $1 = "twig" ] || [ $1 = "ZendOptimizerPlus" ]; 
    then
        cd $2 && \
        phpize \
        && ( \ 
        if [ $5 = "arm64" ]; 
        then
            ./configure --build=aarch64-unknown-linux-gnu; \
	    else
            ./configure; \
        fi; \
        ) \
        && make -j$(nproc)\
        && make install; \
    else
        cd /tmp && \
        mkdir $4 && \
        tar zxf $1 -C $4 && \
        cd $2 && \
        # Configure , make and install extension
        phpize && \
        ./configure --build=aarch64-unknown-linux-gnu  && \
        make && \
        make install; \
    fi && \
    docker-php-ext-enable $3 && \ 
    cd ~ && \
    if [ $1 = "twig" ] || [ $1 = "ZendOptimizerPlus" ]; 
    then
        rm -rf $4;
    else
        rm /tmp/$1 && \
        rm -rf $4;
    fi && \
    echo 'Finished installing extension '$3
}
installextension $1 $2 $3 $4