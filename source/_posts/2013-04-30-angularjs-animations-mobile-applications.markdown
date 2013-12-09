---
layout: post
title: Using AngularJS views animations for mobile applications
date: 2013-04-30 20:20
comments: true
categories: AngularJS mobile
author: Julien Bouquillon
---

AngularJS team recently added the very expected animation feature to their framework. You can have a great overview with the [Miško Hevery introduction video](http://www.youtube.com/watch?v=cF_JsA9KsDM) and a complete overview article at the great [Year of Moo blog](http://www.yearofmoo.com/2013/04/animation-in-angularjs.html).

From now (AngularJS 1.1.4), you can easily animate any directive, just by adding an `ng-animate` attribute and defining the animation CSS class.

**UPDATE** : AngularJS team [fixed the following](https://github.com/angular/angular.js/commit/fd21c7502f0a25364a810c26ebeecb678e5783c5) problem in the last 1.1.5 release. The ng-animate will now be evaulated on each animation, Yahoo :)

**UPDATE** : Just created an much more simpler example based on AngularJS 1.2; check it out : [http://embed.plnkr.co/p7WZdsy0FznV3zo7VWjU/](http://embed.plnkr.co/p7WZdsy0FznV3zo7VWjU/)

As a mobile web developer, the first thing that come to mind is animating your mobile applications views. Its quite easy to add slide-in effects with the current routing system :

{% jsfiddle 8pny4 result,js,html,css light 300px %}

As you can see, the code is very simple code and the animation is always the same (appear from right). But typically, if you open a screen in your mobile application, and there is a 'Back' button, the user expects the slide animation to be reversed when he touches it. If you don't do this, you expose your users to an unexpected behaviour, and an akward #WTF moment.

With the actual AngularJS implementation, there is a problem with the `ng-view` directive, which is heavily used for the AngularJS routing : it doesn't handle dynamic `ng-animate` directive at all, despite what says the doc. You can only set the enter and leave animation once, because these [are set at linking time](https://github.com/angular/angular.js/blob/400f9360bb2f7553c5bd3b1f256a5f3db175b7bc/src/ng/directive/ngView.js#L173) in case of the ng-view. And thus, you can only have one pre-defined enter and leave animation for your application view and for the whole application lifecycle.

There are a [few](https://github.com/angular/angular.js/issues/2480) [issues](https://github.com/angular/angular.js/issues/2464) opened and we can hope the team must be working on it and that should be resolved some day.

But an easy workaround to achieve this is to act on the enter and leave CSS classes themselves directly. Instead of changing the CSS classes names at the DOM level, one could update the CSS classes definitions to achieve the same result without even touching the DOM. The ng-view directive still has the same enter and leave CSS classes names and instead we change theses classes definition, and thus the animation direction.

There are several ways to do this. We could dynamically add a stylesheet to the document, or change the stylesheet source using `ng-src` attribute but this wouldn't be very efficient due to multiple downloads of the ressource. 

But, as we are AngularJS powered, we could simply **bind a style tag to a javascript variable** so it can be updated dynamically like any other DOM element.

Here's how we've done bi-directionnal animations for the ng-view. Note the usage of the `ng-bind-html-unsafe` that take cares of not escaping the CSS output and the use of `transition` and `transform` CSS properties to force the use of GPU and improve the animation smoothness, especially on mobile devices.

{% jsfiddle UvP54 result,js,html,css %}

Another clever solution, as pointed out by Andrej in the comments below, is to simply wrap the `ng-view` in another div that have a dynamic class name, which could change when we need to change the animation direction, like `LR` then `RL`. This way we just need to update that classname and the CSS will pick the good one.

```css
.LR .enter-setup {...}
.LR .leave-setup {...}
.RL .enter-setup {...}
.RL .leave-setup {...}
```
