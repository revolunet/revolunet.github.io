---
layout: post
title: Making of the angular-carousel
date: 2013-05-2 00:00
comments: true
categories: AngularJS mobile
author: Julien Bouquillon
published: false
---

Our first real life project with AngularJS is a mobile and touch-friendly carousel directive.

The goal is to transform any `ng-repeat` directive in a carousel, just by adding the `rn-carousel` attribute to its `ul` container. The directive take care of the dirty work for you, without any jQuery.

That means you can convert any kind of ng-repeat template into a carousel, with just 10 LOC :

{% jsfiddle 3QBEE result,html,js,css light 330px %}

As this project shed some lights on various AngularJS aspects, we'd like to share it with you;

This `rn-carousel` directive is responsible of :

**1) wrapping the real ul/li in a carousel container and add CSS classes**

The directive link function uses the JQlite `wraps` method to add a container to the original `ul` element. Theorically, template modification should happen in the directive `compile` phase, but specifically wrapping the original template here is impossible as it leads to an infinite recursion loop. (AngularJS will wrap again an again as the original directive stays untouched).

We also add some CSS classes to make the ul/li suitable for the carousel and also a carousel instance specific class so we can target it easily later.


**2) watching the ng-repeat expression**

Because we want to monitor precisely which items are in our carousel, we need to extract and watch the `ng-repeat` expression. We can then watch that expression and then be notified when the `ng-repeat` is updated. This is useful to know how many slides we have and also to update our indicators accordingly.

This extraction is done by literally parsing the `ng-repeat` expression in a generic way. [Credits goes to @bennadel](http://www.bennadel.com/blog/2457-Accessing-scope-On-The-DOM-Using-AngularJS.htm) for this awesome trick.

**3) binding touch and click events**

Like most directives, we bind events in the linking phase. We just take care of binding both touch and mouse events.

**4) animating the slides smoothly**

When we detect a `touchstart` we just store the event position. On `touchemove` we update the horizontal offset and move the whole `ul` accordingly using CSS. Then on `touchend`, we detect the desired position (prev or next) and do some control. We then dynamically add CSS styles and classes to move the slides to the new desired position, or restore the current position in some cases.

The slide movement is made thanks to the CSS `transition` property and uses the CSS `transform` property to force CSS 3D transforms and thus animate using the GPU which make the movement much more smooth especially on mobile devices.

**5) adding an indicator to our carousel**

As we already watch the `ng-repeat` expression its quite easy to bind indicators to our carousel. You can enable the indicators with a `rn-carousel-ìndicator="true"` attribute on your `ul`.

The indicator is another directive, with `ìtems` and `index` passed in scope and just some CSS.

**6) offer a two-way data binding for the active slide index**

blabla


**7) tests, grunt automation...**

blabla


**Easy isn't it ?**


There are still somes limitations though : 

 - ony works with ul/li structure
 - carousel dimensions is based on the first li detected
 - we should implement slides buffering so the ng-repeat is rendered progressively not entirely





