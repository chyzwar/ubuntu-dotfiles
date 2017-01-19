#!/bin/sh

old=Chyzwar
new=chyzwar
git remote -v | grep $old | while read name url type; do
    newurl=`echo $url | sed -e "s/$old/$new/"`
    git remote set-url $name $newurl
done
