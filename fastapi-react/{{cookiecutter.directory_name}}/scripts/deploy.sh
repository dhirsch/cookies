#1/bin/bash

set -e
. ~/.nvm/nvm.sh
nvm use

echo $1

TARGET_ENV=$(echo $1 | awk '{print tolower($0)}')
ROOT_DIR=$(pwd)
BUILD_DIR="$ROOT_DIR/build"

echo $TARGET_ENV

if [[ $TARGET_ENV == "prod" ]]; then
    YARN_CMD="build"
    GCP_PROJECT="{{cookiecutter.gcp_project_prod}}"
else
    echo "Unrecognized target environemnt. Exiting..."
    exit 1
fi

echo "Building and deploying to $TARGET_ENV\n\n"

echo "Removing old build directory"
rm -Rf $BUILD_DIR
mkdir -p $BUILD_DIR

echo "Building web"
cd $ROOT_DIR/web && yarn $YARN_CMD

echo "Copying web"
cp -R $ROOT_DIR/web/build/* $BUILD_DIR

echo "Ouputting requirements.txt"
cd $ROOT_DIR/server
poetry export -f requirements.txt -o requirements.txt --without-hashes

echo "Copying server"
cp -R $ROOT_DIR/server/* $BUILD_DIR

gcloud app deploy --project $GCP_PROJECT $BUILD_DIR
