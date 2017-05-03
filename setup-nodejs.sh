#!/usr/bin/env bash

function open_node_download {
    echo "Please visit ..."
    echo "https://nodejs.org/en/download/"
    echo "... to download and install Node JS v6.10.2"
    exit 1
}

if which node > /dev/null
    then
        echo "Node JS found, version: $(node -v)"
    else
        echo "Node JS missing."
        open_node_download
        exit 1
fi

NODE_MAJOR_VERSION=`node -v | sed -n "s/^v\([0-9]\).*/\1/p"`

if [ $NODE_MAJOR_VERSION -lt 4 ]
    then
        echo "Node JS version $(node -v) is not sufficient. Please upgrade."
        open_node_download
        exit 1
fi

echo
echo "Installing NPM dependencies ..."

pushd Lesson2_CreateViewWithEventConsumer/winner-view
npm install
popd

pushd Lesson3_PublicEndpointToAccessView/winner-api
npm install
popd
