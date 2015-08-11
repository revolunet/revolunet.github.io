---
layout: post
title: Making of the angular-carousel
date: 2013-05-2 00:00
comments: true
categories: AngularJS mobile
author: Julien Bouquillon
---

Our first real life experiment with AngularJS is a mobile and touch-friendly carousel directive.

As this project shed some lights on various AngularJS aspects, we'd like to share it with you;
The full demo+code is available here : [http://blog.revolunet.com/angular-carousel](http://blog.revolunet.com/angular-carousel)

The goal is to transform any `ng-repeat` directive into a carousel, just by adding the `rn-carousel` attribute to its `ul` container. The directive take care of the dirty work for you, without any jQuery.

Here's a very basic example of a Youtube API call, with the data displayed in a regular Angular template; We just add a `rn-carousel` attribute to the `ul` element to ask a carousel :)

{% jsfiddle 3QBEE result,html,js,css light 330px %}

This `rn-carousel` directive is responsible of :

**1) wrapping the real ul/li in a carousel container and add CSS classes**

We first wrap the original `ul` block in an outer div using JQlite `wraps` method during the directive link phase. This cannot be doneduring the compile phase as it would lead to an infinite recursion loop. (AngularJS will wrap again an again as the original directive stays untouched).

Then we add some CSS classes and an unique carousel identifier class so we can target that instance easily later.

The CSS makes the ul/li block appears as a single horizontal line composed of many li blocks, so its very easy to slide the blocks horizontally.


**2) watching the ng-repeat expression**

Because we want to monitor precisely the items in our carousel, and we want to be able to dynamically add/remove items, we need to extract and watch the original `ng-repeat` expression. We can then watch that expression and then be notified when its updated. This is useful to know how many slides we have and update our indicators accordingly for example.

~~This extraction is done by literally parsing the ng-repeat expression in a generic way, using the generated normalized comment node. [Credits goes to @bennadel](http://www.bennadel.com/blog/2457-Accessing-scope-On-The-DOM-Using-AngularJS.htm) for this awesome trick~~. 

**Update :** I ended up with just extracting the li `ng-repeat` attribute during the `compile` phase which is much less overhead.

**3) binding touch and click events**

Like most directives, we bind events in the linking phase. We just take care of binding both touch and mouse events.

```js
// bind events
container.bind('mousedown touchstart', swipeStart);
container.bind('mousemove touchmove', swipe);
container.bind('mouseup touchend', swipeEnd);
```

**4) animating the slides smoothly**

When we detect a `touchstart` we just store the initial event position. On `touchemove` we update the horizontal offset and move the whole `ul` accordingly using CSS. Then on `touchend`, we detect the desired position (prev or next) and dynamically add CSS styles and classes to move the slides accordingly, or restore the current position in some cases.

The slide movement is made thanks to the CSS `transition` and `translate3d` properties to force CSS 3D transforms and thus animate the slides using the GPU which make the movement much more smooth especially on mobile devices.

```js
// the offset value is simply : desiredSlideIndex * slideWidth
carousel.css({
    '-webkit-transform': 'translate3d(' + offset + 'px,0,0)',
    '-moz-transform': 'translate3d(' + offset + 'px,0,0)',
    '-ms-transform': 'translate3d(' + offset + 'px,0,0)',
    '-o-transform': 'translate3d(' + offset + 'px,0,0)',
    'transform': 'translate3d(' + offset + 'px,0,0)'
});
```

**5) adding an indicator to our carousel**

As we already watch the `ng-repeat` expression, we track the number of slides in the carousel and so its quite easy to add data-bound indicators to our carousel. You can enable these by adding a `rn-carousel-indicator="true"` attribute on your `ul`.

The indicators are produced by the `rn-carousel-indicators` directive, completely decoupled, during the linking phase. For the directive to be executed, we compile it through the `$compile` service before appending it to our container.

It just takes `items` and `index` attributes that will be injected in an isolated scope to produce the indicators and set the CSS classes.

```js
// enable carousel indicator
var showIndicator = (iAttrs['rnCarouselIndicator']==='true');
if (showIndicator) {
    // as the HTML contains a directive, we need to $compile it
    // before appending it to our container
    var indicator = $compile("<div id='" + carouselId +"-indicator' " + 
        " index='carouselIndex' items='carouselItems' rn-carousel-indicators " +
        " class='rn-carousel-indicator'></div>"
    )(scope);
    container.append(indicator);
}
```
**6) offer a two-way data binding for the active slide index**

The carousel current index position can be data-bound to an optional `rn-carousel-index` attribute if provided. This allows you to display the carousel position somewhere else, add custom controls/indicators, initialise to a different slide...

```js

// set initial position at first slide
scope.carouselIndex = 0;

if (iAttrs.rnCarouselIndex) {
    //  if a binding attribute is present, use it.
    var activeModel = $parse(iAttrs['rnCarouselIndex']);
    scope.$watch('carouselIndex', function(newValue) {
        // when the carousel internal index changes, update the model
        activeModel.assign(scope.$parent, newValue);
    });
    scope.$parent.$watch($parse(iAttrs.rnCarouselIndex), function(newValue) {
        // when the model change, update the local position
        // this is also useful for the initial position
        scope.carouselIndex = newValue;
        updateSlidePosition();
    });
} else {
    // if no index attribute, just watch internal index and update display
    scope.$watch('carouselIndex', function(newValue) {
        updateSlidePosition();
    });
}
```

The `updateSlidePosition()` function simply moves the `ul` block based on the `carouselIndex` value and the width of the slides. We do this with CSS transition and `translate3d` so this is animated and hardware accelerated.

**7) tests and grunt automation**

These subjects will have a dedicated article soon :)

**Limitations**

 - Only works with ul/li structure
 - Carousel dimensions is based on the first li detected

**UPDATE** : the carousel can now be buffered to improve performance with large datasets !


**Easy isn't it ?**

If you have questions, suggestions, issues, pulls requests... just comment below or on Github :)




