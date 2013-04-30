---
layout: post
title: Octopress Cheat Sheet
date: 2013-04-15 01:46
comments: true
categories: octopress
author: Julien Bouquillon
---

When you switch to Octopress for blogging there are a very few thing to know :

```bash
# create a new post
rake new_post['Title of the post']

# create a new page 
rake new_page['Title of the page']

# preview your work
rake preview

# publish it
rake generate && rake deploy

# commit and backup(automatic message)
git commit -am "`date`" && git push origin source

```
