---
layout: post
title: The web developer survival guide
date: 2015-09-04 00:00
comments: true
categories: web
author: Julien Bouquillon
---

Applicable mostly to frontend web development teams.

Comments welcome :)

On the same subject, by Eric Eliott : [How to Build a High Velocity Development Team](https://medium.com/javascript-scene/how-to-build-a-high-velocity-development-team-4b2360d34021)

Even if the main factor for a project success is human relations, providing a friendly, secure and comfy development workflow for your team is essential to improve happiness, and thus encourage high-quality standards.

## TL;DR

 - Premature optimisation is the root of all evil
 - Simple and fast dev workflow
 - Standards tools
 - Early feedback
 - Modularity
 - Quality

## Project management

Reduce the number of tools you use :

 - Issues, milestones... : GitHub + ZenHub
 - Slack for centralized communication
 - Markdown :)

As a product owner, define clear goals and deadlines, and detailed user stories and mockups that will act as base reference for future milestones.

As a developer, expose your plans when starting working on a new feature so you can have early feedback from your team. Github issues are cool for that. Think [Readme Driven Development](http://tom.preston-werner.com/2010/08/23/readme-driven-development.html).

Avoid slack-driven-development which can lead to precipitate design decisions, premature optimisations and throwaway features through endless chats; prefer argumented GH issues.

Dont wait months to receive feedback on your feature. Release early to get early end-user feedback and favour useful features.

![lean](http://2.bp.blogspot.com/-Yjx5G4Nihko/VWYhDiery2I/AAAAAAAACOY/49BYuU3SJ7s/s1600/Spotify.png)


## Versionning

Use GIT with GitHub and a simple but [effective model](https://gist.github.com/jbenet/ee6c9ac48068889b0912).

TL;DR :

 - Production-ready `master` branch
 - Pull requests from feature-branches to `master`
 - Hotfixes pull requests to master
 - Always mention related issues in commit messages
 - Use a `develop` branch to receive PRs for huge upgrades
 - Never, ever, `push --force` to a shared branch

![github flow](http://nicoespeon.com/assets/img/git/github-flow-branching-model.jpg)

Use [standard commit messages](https://gist.github.com/stephenparish/9941e89d80e2bc58a153), respect [SemVer](http://semver.org/) :  Breaking.Feature.Patch.

See [semantic-release](https://github.com/semantic-release/semantic-release) for automatic semver based on commit messages.


## Standards

Choose and use battle-tested industry tools, standards and styleguides.


Provide sane and homogenous defaults for developer environnement :

 - .editorconfig
 - .babelrc
 - .eslintrc
 - npm scripts

Don't rush on the new hype; Tools are continuously and fastly improving but early adoption means upgrading the whole team skills and may have significant impact on your workflow.

Experiment, make proof-of-concepts, evaluate advantages and anticipate migrations.

Once maturity is here and adoption is wide enough and if effort is worthwhile, engage progressive migration.

## Modularity

You don't want to create a monolithic, highly-coupled application.

Break problems into smaller parts.

From the UNIX philosophy : Build small programs that do one thing, do it well, and compose easily with other programs.

Which means small, focused, testable and tested JavaScript modules, providing a nice API.

see [JS Modules best practices](https://github.com/mattdesl/module-best-practices) and [FIRST principles](http://addyosmani.com/first/)

npm ecosystem is an incredible ressource for JavaScript modules which  come with already existing tests and corner-cases solved for you. USE IT !

npm is a also a powerful packaging tool that makes it easy to publish your own modules and manage dependencies at scale.

By separating concerns of your modules you'll improve your velocity and reduce hassle due to working in complex contexts.

Focusing on a specific problem without worrying about third party is the key to solve it.

![NPM](https://openmerchantaccount.com/img/lego-adjusted.jpg)

## Quality

Unit tests will build trust, save your ass, and make the developer feel more confident to work without breaking something, thus, make him/her much more productive, and happy.

Test the public API, not the internal implementations.

 - [5 Questions Every Unit Test Must Answer](https://medium.com/javascript-scene/what-every-unit-test-needs-f6cd34d9836d)
 - [Why I use Tape instead of Mocha & so you should](https://medium.com/javascript-scene/why-i-use-tape-instead-of-mocha-so-should-you-6aa105d8eaf4)

Test coverage will give you cool insights and motivate you to do more.

Add UI tests (aka "smoke tests") to ensure integration and prevent repetitive and boring manual in-browser course tests.

Tests won't guarantee your code is bug-free but will increase quality (early bug fixes + easy refactoring), and most importantly, allow developers to iterate quickly in confidence.

The earlier the bugs are discovered, the cheaper they are to fix.

![bugs cost](http://www.jamkey.fr/wp-content/uploads/2015/05/bugs-prices.png)

## Developer Experience

Offer powerful MacBooks or Linux laptops.

Comment the code (JsDoc) and provide nice README.md files.

Adding inline comments is cheap and helps later refactoring; Explain the WHY of your code when its not obvious.

Make development fast and easy : when working on a new feature, the developer should be able to install the environment quickly, and iterate with blazing-fast build times and hot-reload.

Choose a solid boilerplate with all your sane defaults.

 - for react : [rackt-cli](https://github.com/mzabriskie/rackt-cli)
 - for angular : [generator-gulp-angular](https://github.com/Swiip/generator-gulp-angular) - see also [ng-factory](https://github.com/ng-tools/ng-factory), the upgradable development workflow for AngularJS.
 - for node+babel : [node-babel-boilerplate](https://github.com/revolunet/node-babel-boilerplate)

## Team

Work hard, Play hard.

Be nice and always be yourself.

There's nothing as powerful as trust when you want to move mountains.
