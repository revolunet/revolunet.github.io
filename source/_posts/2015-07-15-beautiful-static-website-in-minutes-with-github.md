---
layout: post
title: Create and host a beautiful website for free using GitHub
date: 2015-07-15 00:00
comments: true
categories: web
author: Julien Bouquillon
---

In this tutorial i'll show you how you can setup, publish and host a nice single-page website in minutes and completely free of charge using Github pages.

I assume you're you are already familiar with :

 - **HTML** : [cheat sheet](http://www.cheatography.com/davechild/cheat-sheets/html4/)
 - **GitHub** : create a free account here : [github.com](http://github.com)

We'll use the awesome GitHub.com to host our **static website** and create it using an existing template. Github hosts your website code history publicly and you benefit, among other things, from code versionning and free, high-quality hosting (cdn, ddos protection...).

**WARN** Files stored on Github are public to anyone (except if you buy a private repo), so don't store anything sensible here.

## What is a "static" website ?

For small websites, CMS solutions like WordPress and equivalents are largely overkill and require some technical setup and mandatory maintenance mostly due to security patches and unattended upgrades.

Nowadays, it is possible to create awesome websites in a server-less way, using only client-side technologies. This mean you can host your website anywhere without any configuration, as all the code executes is only in the final user browser (HTML, Javascript and CSS), and this has several advantages :

 - simple
 - no maintenance
 - no hacking
 - better performance
 - less is more
 - simple is beautiful

Any serious business now offers an API that you can integrate in some way your static website if you need so this static approach has **NO LIMIT**.

Next articles will provide more advanced examples using a [static website
 generator](https://www.staticgen.com/).

## Create the Github repository

create a new repository for your website : [https://github.com/new](https://github.com/new) ex: mywebsite

This will create a public repository at [https://github.com/USERNAME/mywebsite](https://github.com/USERNAME/mywebsite)

## Single page website with Github page generator

3-clicks setup using one of the GitHub built-in templates

Go to your github project page, [https://github.com/USERNAME/mywebsite](https://github.com/USERNAME/mywebsite)

 - Go to **repository settings** (icon in the right-bottom)
 - **Automatic page generator** and click **Launch**
 - Edit your website text
 - Select a template and **Publish Page**

Wait a few seconds and goto : [http://USERNAME.github.io/mywebsite](http://USERNAME.github.io/mywebsite)

**✔** your website is up :)

## Edit the website online

Go to your github project page, [https://github.com/USERNAME/mywebsite](https://github.com/USERNAME/mywebsite)

This is all your websites files.

Click the file you want to edit, for example `index.html` (main page), make your changes then click the "pen" icon on top-right of the editor.

Under the file editor there's a "Commit changes" form, set the title to a good description of your changes : ex: "contact info update"

Press **Commit changes** button.

Wait a few seconds and goto : [http://USERNAME.github.io/mywebsite](http://USERNAME.github.io/mywebsite)

**✔** your website is updated :)

## Edit the website on your computer

For more advanced edition and comfort you may want to edit from your [preferred text editor](http://atom.io) on your computer.

Setup the GitHub app with your account : [mac.github.com](http://mac.github.com) or [windows.github.com](http://windows.github.com)

 - **Clone** the project on your computer, it will download the code from github
 - **Edit** the files on your computer, add javascript, images, etc...
 - **Test** if everything works locally
 - Then **Commit** those files with an explicit message from github app
 - **Sync** with Github

**✔** your website is updated :)

## Test the website locally

You can open the file in your web browser to test the result.

**WARN** If you added google maps or some javascript API, be sure to run `python -m SimpleHTTPServer` from your console in the project folder, and use http://127.0.0.1:8000 in the browser.


## Use great templates

If you want different templates than github ones, you just need to replace your repository content with the new one.

Choose one of the high-quality template from [html5up.net](http://html5up.net) or [pixelarity.com](http://pixelarity.com), download and extract to your project folder.

Edit the files, test, commit & sync and you're done.

## Next steps

Learn Markdown syntax : [reference](https://en.support.wordpress.com/markdown-quick-reference/)

Learn GIT : [try.github.io](https://try.github.io)

Learn Javascript : [jsbooks.revolunet.com](http://jsbooks.revolunet.com) and [Eric Elliott book](https://ericelliottjs.com/product/programming-javascript-applications-paper-ebook-bundle/)

## FAQ
### How do i setup a domain name ?

 - Buy a domain from [gandi.net](http://gandi.net) (or other serious one)
 - Edit the domain "DNS zone" and follow the [github dns instructions](https://help.github.com/articles/tips-for-configuring-a-cname-record-with-your-dns-provider/)
 - add `CNAME` file, containing `www.myproject.com`, to your repository

The DNS changes can take up to 24h before propagating so try www.myproject.com tomorrow

Github Help :  [custom domain](https://help.github.com/articles/setting-up-a-custom-domain-with-github-pages/), [dns setup](https://help.github.com/articles/tips-for-configuring-a-cname-record-with-your-dns-provider/)

### How to add a page ?

Just add some more html files, like "products.html" and add a link to it from index : `<a href="products.html">products</a>`.

### How to get traffic analytics ?

If you want to track your visitors and analyse where they come from and what they do on your website, create an account on [Google Analytics](http://www.google.com/analytics) and add the tracker to your page code.

### How to add a Map ?

If you need an interactive map, you can follow [Google Maps instructions](https://developers.google.com/maps/tutorials/fundamentals/adding-a-google-map).

Alternatively, follow [Leaflet instructions](http://leafletjs.com/examples/quick-start.html) to take avantage of the OpenStreetMap project, which is community driven, free and open source.

If you just need a map image : generate the HTML code from here : [staticmapmaker.com](http://staticmapmaker.com) ad copy the "HTML" to your page. Full static images doc : [https://developers.google.com/maps/documentation/staticmaps/](https://developers.google.com/maps/documentation/staticmaps/)

### How to add comments ?

Create an account on [disqus.com](disqus.com) and add the javascript code to your page.

### How to add a contact form ?

Create an account on [typeform.com](typeform.com) and add the javascript code to your page, create the form there and copy the javascript "embed" code to your page.

Alternatively : Create an account on [mailchimp.com](mailchimp.com), create the form there and copy the javascript "embed" code to your page.

### How to receive payments ?

Create an account on [stripe.com](stripe.com) and add the javascript code to your page.


### What is gh-pages ?

`gh-pages` is a special "branch" (source code version) on github that automagically publish and host a static website.



If you have any question, feel free to ask below :)
