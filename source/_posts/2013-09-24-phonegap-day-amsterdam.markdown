---
layout: post
title: Phonegap day Amsterdam 2013
date: 2013-09-24 00:00
comments: true
categories: javascript mobile phonegap
author: Julien Bouquillon
---

Once again, i've been lucky enough to go to Amsterdam today to attend the Phonegap Europe annual conference.

The [venue](http://www.compagnietheater.nl/compagnietheater.html) was great, the talks covered various subjects, and, most importantly, the atmosphere reflected a positive and healthy community : open-minded and confident in the open web as a major platform for the future of mobile applications.

Almost 2 years after Adobe took control of Nitobi (the team behind the Phonegap genesis), the Phonegap project is in a great shape, dynamic, more open than ever, and with a sane and solid codebase, powered by node.js and a modern javascript toolchain, thanks to the hard work of the core team and many contributors.

With the 3.0 version, released a few weeks ago, Phonegap is now mature and flexible enough to serve as a foundation for your various mobile projects. Every single plugin has been extracted from codebase, which is now focused on bridging performance and plugin management. 

**Phonegap is the perfect example of how open source can increase code quality and grow a solid community while serving a company business.**

Here is a quick recap of the most notable talks.

### Distimo

Distimo is an app-analytic company that analyses app downloads, conversions and profits and compute smart data for the app developers.

They shared some interesting metrics :

 - 33% of worlwide app revenues comes from Asia.
 - Globally, ~65% of revenues comes from the AppStore and ~35% from Play Store (growing fast).
 - Candy Crush saga makes as much money in Asia on both iOS or Android
 - Games of course dominates stores revenues

More data at : [http://www.distimo.com/publications](http://www.distimo.com/publications)

### Untappd

Demo of one of the most successfull Phonegap apps : Untappd, a beautiful beer-centered social network app with 700k users and 4 stars rating. [Join now !](https://untappd.com/)

### Blackberry loves the web

Too late maybe ?

### Native UI in Phonegap Apps

Tanaka Masahiro demoed the [Monaca hybrid framework](https://github.com/monaca/monaca-framework-ios) which gives you the ability to add native UI elements to your Phonegap app. You can wrap the phonegap webview with native tabbar/navigation bar to improve your UX, specially revelant on older Android devices. The framework also allows native transitions between various webviews, but this breaks application state. The framework hasn't yet migrated to phonegap 3.0 so not usable as is IMHO.

Interesting real hybrid approach that demonstrates again that Phonegap is not necessarly a "full web" solution, but you can use as much "native" stuff as needed.

### Apple phonegap apps rejection prevention

[Rob Lauer](https://twitter.com/rdlauer) from [kendoui](http://www.kendoui.com/) shared his experiences about mobile web apps rejection reasons on the Apple Store.

Here's a bunch of common best practices to prevent your Phonegap app to be rejected :

 - Make an app, not a website
 - Create unique and useful apps
 - Don't use annoying ads
 - User registration shouldn't be mandatory (at least a free demo access)
 - Don't force users to validate CGU
 - Never tag your app version lower to 1.0
 - Should work offline with minimal features
 - Don't load remote code that change your app behaviour
 - Use beautiful, homogenous icons
 - Write accurate app description
 - Don't try to steal Apple money, use in-app payments or die instantly


### Topcoat.io

Kristofer Joseph, original [TopCoat](http://topcoat.io) author, talked about this beautiful and slick CSS framework focused on performance and themability.

TopCoat.io provides various widgets as pure HTML/CSS and, most importantly, provides the best technical stack ever to extend it cleanly :

 - [BEM CSS syntax](http://csswizardry.com/2013/01/mindbemding-getting-your-head-round-bem-syntax/) convention
 - [grunt](http://gruntjs.com)-based automation
 - [npm](npmjs.org) dependencies management
 - [TopDoc](https://github.com/topcoat/topdoc) documentation generator
 - [chrome telemetry](http://www.chromium.org/developers/telemetry)  performance analysis
 - [codepen.io](codepen.io) as a prototyping tool
 - What else ??

Another great example of a successful project, open-sourced from day one and following the best practices from the ground up.

TopCoat is definitely shaped for the future and you can already use it in your Phonegap projects !

Check out [@devgirlfl](https://twitter.com/devgirlfl) article & demo : [http://devgirl.org/2013/08/29/totally-rad-topcoat](http://devgirl.org/2013/08/29/totally-rad-topcoat/)


### WizCorp HTML5 gaming

Yes you can build great games with Phonegap. You don't necessarly draw directly inside the webview, but as phonegap is very open and extensible, you can easily plug native features as needed, like [Ejecta](http://impactjs.com/ejecta) (off browser canvas+audio for iOS), webGL views... WizCorp team shares some interesting code [on their github](https://github.com/Wizcorp), like a native spinner, navigation views helper...

### Chrome Cordova plugins

This may be the biggest announce of this event : We can now use Chrome APIs right in our cordova applications. For the moment, we just have socket, storage, notifications, and identity (oauth), but in a near future, we'll see support for syncFileSystem (synced data across devices) and more. 

Basically, this means that you can code a Chrome Packaged App using only chrome APIs, then distribute it on desktop via the chrome store and then on mobile app stores using cordova !

This is very early stage but Google puts some efforts to stabilize and extend capabilities quickly.

All Chrome javascript APIs : [http://developer.chrome.com/apps/api_index.html](http://developer.chrome.com/apps/api_index.html)

Cordova implemented APIs can be found at : [http://plugins.cordova.io](http://plugins.cordova.io)


### Testing with appium.io

[Fil Maj](http://twitter.com/filmaj) demonstrated [appium](http://appium.io), an open source end-to-end testing platform that fully support phonegap applications. You can write automation scripts (think selenium) then run them on your own devices, or use appium infrastructure to run the tests on various devices and produces detailed reported. 

In a world of such devices fragmentation, this can be very useful :)

### Firefox OS

Phonegap now also support Firefox OS ;) and Firefox provides many more javascript APIs, like 'Activites' (think Web intents). If you support the real open web, Mozilla is definitely the way to go :)

### Phonegap CLI

This awesome talk by [Michael Brooks](twitter.com/mwbrooks) was the most interesting and technical talk of the day. Michael showed us how powerful the cordova and phonegap CLI are. Based on a cutting edge javascript architecture, the phonegap CLI is made of nodes modules that you can use directly in the CLI, or as external nodeJS modules, which allows you to integrate the whole workflow in third-party tools and vice-versa. open source power :)

He also demonstrated how easy it is to create and compile apps with or without the locally installed SDKs, using phonegap build as a fallback. Just run for example `phonegap compile ios` from your machine, then in seconds you get back a QRcode that you can scan to test your final app on a real device instantly; neat !


#### Finally, a big thanks to [Colene](https://twitter.com/colene), [Peter Paul Koch](https://twitter.com/ppk) and all the Phonegap team for this event, can't wait for next year :)
