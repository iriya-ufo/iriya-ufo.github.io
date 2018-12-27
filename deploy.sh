#!/bin/bash

if [[ $(git status -s) ]]
then
    echo "The working directory is dirty. Please commit any pending changes."
    exit 1;
fi

echo -e "*** Deleting old publication...\n"
rm -rf public

echo -e "*** Generating site...\n"
hugo

echo -e "*** Adding CNAME...\n"
echo iriya-ufo.net >> public/CNAME

echo -e "*** git add && git commit...\n"
git add public/
git commit -m "release `date '+%Y-%m-%d %H:%M'`"

echo -e "*** Updating master branch...\n"
git subtree push --prefix public/ origin master

echo -e "*** Updating source branch...\n"
git push origin source

echo "*** Success Deploy !!!"
