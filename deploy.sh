#!/bin/bash

if [[ $(git status -s) ]]
then
    echo "The working directory is dirty. Please commit any pending changes."
    exit 1;
fi

echo "\U2705 Deleting old publication...\n"
rm -rf public

echo "\U2705 Generating site...\n"
hugo

echo "\U2705 Adding CNAME...\n"
echo iriya-ufo.net >> public/CNAME

echo "\U2705 git add && git commit...\n"
git add public/
git commit -m "release `date '+%Y-%m-%d %H:%M'`"

echo "\U2705 Updating master branch...\n"
git subtree push --prefix public/ origin master

echo "\U2705 Updating source branch...\n"
git push origin source

echo "\U2705 Success Deploy !!!\n"
