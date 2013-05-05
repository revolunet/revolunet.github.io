---
layout: post
title: Octopress Cheat Sheet
date: 2013-04-15 01:46
comments: true
categories: octopress
author: Julien Bouquillon
---

When you switch to Octopress for blogging there are a very few things to know :

## Command line

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

## Creating a post

You can create a post just by adding a .markdown file in the source/_posts folder and preview it with `rake preview`. The name of the file will be your post url so use an appropriate [slugified name][1].

You must add some metas at the top of the file :

```
---
layout: post
title: My Awesome article.
date: 2013-05-1 00:00
categories: news technology web
author: Super Man
comments: true
published: false
---
```

If you set `published: false`, your posts will only be visible in preview mode.


## Publish

When ready, just use `rake generate && rake deploy` to publish it :)

Here's a micro script to simplify the publish process, jsut put it in the blog root folder :

```bash
#!/bin/sh
# push.sh : publish & commit with a single command
git add source
git commit -am "`date`" && git push origin source
rake generate && rake deploy
```


 [1]: http://en.wikipedia.org/wiki/Slug_(web_publishing)#Slug
