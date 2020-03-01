#!/bin/bash

FOLDER="/extrakeys"

if [ -d "$FOLDER" ]; then
    for src in $(find $FOLDER -name '*.asc'); do
        gpg --import --batch --yes $src
    done
else
    echo "$FOLDER does not exist, skipping import."
fi