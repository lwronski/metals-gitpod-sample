
 #!/bin/bash

METALS_DIR="$GITPOD_REPO_ROOT/.metals"
APPS_DIR="$METALS_DIR/apps"
METALS_VERSION="0.11.1"
COURSIER_CACHE=".cache"

mkdir -p $COURSIER_CACHE

mkdir -p $APPS_DIR

export COURSIER_CACHE=$COURSIER_CACHE

export PATH=$PATH:/usr/local/openjdk-8/bin:$APPS_DIR

curl -Lo $APPS_DIR/cs https://git.io/coursier-cli-linux && chmod +x $APPS_DIR/cs

eval "$(cs java --jvm zulu:17 --env)"

cs fetch org.scalameta:metals_2.12:$METALS_VERSION --cache=$METALS_DIR/coursier 
cs fetch org.scalameta:scalafmt-cli_2.12:3.3.3 --cache=$METALS_DIR/coursier 

curl -Lo $APPS_DIR/cs https://git.io/coursier-cli-linux && chmod +x $APPS_DIR/cs

echo "export PATH=\$PATH:/usr/local/openjdk-8/bin:$APPS_DIR" >> ~/.bashrc

URL="https://github.com/VirtusLab/scala-cli/releases/download/v0.0.9/scala-cli-x86_64-pc-linux.gz"

SCALA_CLI_ARCHIVE="scala-cli.gz" 
curl -fLo "$APPS_DIR/${SCALA_CLI_ARCHIVE}" $URL 
gzip -d "$APPS_DIR/${SCALA_CLI_ARCHIVE}"
chmod +x "$APPS_DIR/scala-cli"

scala-cli run .