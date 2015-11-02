---
layout: post
title: Development workflow with rackt-cli
date: 2015-11-01 00:00
comments: true
categories: web
author: Julien Bouquillon
---


As advertised in my [Web developer survival guide](http://blog.revolunet.com/blog/2015/09/04/the-web-developer-survival-guide/), modularisation is key to keep code maintenable, testable and understandable to others, and npm makes this easy and fun.

> see also [why writing small modules is important](https://github.com/sindresorhus/ama/issues/10) by [@sindresorhus](http://twitter.com/sindresorhus).

But **modularisation is not free**, it comes at the cost of maintenability, specially if you use a complex toolchain like Babel + JSX + Tests... and have dozens of modules to maintain.

In this article, i'll explain what is [rackt-cli](https://github.com/revolunet/rackt-cli), and how it helps to stay productive, with a modern and sane workflow, especially in the context of ReactJS components.

If you're in AngularJS world, be sure to check [ng-factory](https://github.com/ng-tools/ng-factory) from the awesomes [@olouv](http://twitter.com/olouv) and [@douglasduteil](http://twitter.com/douglasduteil), which has the same goals, but with a different tech stack.

Note that i work with a [custom rackt-cli fork](https://github.com/revolunet/rackt-cli), which make workflow even smoother IMHO :)

There are already [tons](https://github.com/xgrommx/awesome-redux#boilerplate) of [good](https://github.com/erikras/react-redux-universal-hot-example) [boilerplates](https://github.com/bloodyowl/react-boilerplate) around for the react stack, but once the boilerplate is used for your project, it became a part of it, and you end up with 50 different tooling for 50 modules.

#### rackt-cli solves this by isolating the workflow tasks from your code, so you can maintain them among various projects.

Basically, it's just an opiniated boilerplate, a set of shared tasks that do the boring stuff for you, and rules to enforce some basic coding and publishing conventions.

## What rackt-cli gives you :

 - **Webpack**, because being able to bundle assets into Javascript is awesome
 - **Babel**, because ES6 is explicit, powerful, and less verbose
 - **Hot-reload**, because a better developer experience means happier developer
 - **Testem + Mocha + expect-jsx**, to test your code in any browser, with CI support.
 - **NPM** : automated NPM publishing (bundle only) + GIT tagging
 - **Changelog** : automated changelog from commits messages with [rf-changelog](https://github.com/ryanflorence/rf-changelog)
 - **Gh-pages** : publish your examples to gh-pages
 - **Eslint** : code conventions based on eslint-react


## Typical workflow

```sh
# create a nice boilerplate for your component
rackt init my-component

# start to make some changes
rackt server
git add awesome.js
git commit -m 'feat: awesome stuff'

# test & publish to npm
rackt release

# publish examples to gh-pages
rackt pages

```

# And that's it :)

You can now focus on your code, tests and documentation !

If you have some suggestions, ideas... feel free to ping me on twitter @revolunet or in the comments below.

My rackt-cli fork : [https://github.com/revolunet/rackt-cli](https://github.com/revolunet/rackt-cli)

Original project : [https://github.com/mzabriskie/rackt-cli](https://github.com/mzabriskie/rackt-cli)

