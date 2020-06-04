#!/bin/bash
cd server
poetry install


cd ../web
. ~/.nvm/nvm.sh
nvm use
yarn install