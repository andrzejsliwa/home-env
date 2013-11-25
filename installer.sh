#!/bin/sh

if [ -d $HOME/home-env ]
then
    cd $HOME/home-env
    git pull
    make clean all
else
    git clone https://github.com/andrzejsliwa/home-env.git ~/home-env
    cd $HOME/home-env
    make
fi
