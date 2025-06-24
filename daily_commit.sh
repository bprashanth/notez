#!/bin/bash

cd ~/rtmp/notez || exit 1

today=$(date +%d%m%y)

git add .
git commit -m "$today"
git push origin main
