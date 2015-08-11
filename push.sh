#!/bin/sh
git add source
git commit -am "`date`" && git push origin source
rake generate && rake deploy
