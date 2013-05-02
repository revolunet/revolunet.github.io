---
layout: post
title: AngularJS tips'n'tricks part 1
date: 2013-05-1 00:00
comments: true
categories: AngularJS
author: Julien Bouquillon
---


In the past few months we learned a lot of new AngularJS stuff. Here is a first bunch of tricks, please comment and help us improve theses exemples if your tricks are even more awesome :)

We compiled most of our [best AngularJS ressources in a gist](https://gist.github.com/revolunet/4657146) and we maintain a list of related  twitter accounts here : [https://twitter.com/revolunet/angularjs](https://twitter.com/revolunet/angularjs).

### Scopes
You definitely need to read this article : [http://stackoverflow.com/questions/14049480/what-are-the-nuances-of-scope-prototypal-prototypical-inheritance-in-angularjs](http://stackoverflow.com/questions/14049480/what-are-the-nuances-of-scope-prototypal-prototypical-inheritance-in-angularjs)

### Directives
The official documentation is not crystal clear at first approach but it documents most of what you need to understand: [http://docs.angularjs.org/guide/directive](http://docs.angularjs.org/guide/directive). So read it. And again. And again.

### Watch an object or a list
If you watch a list or an object with the `objectEquality` parameter not set, then the `$watch` callback won't be triggered if the object is only updated partially. Setting it to `true` will trigger it on any modification; this has performance impact so use carefully.

```js
// the last `true` means compare by value and not by ref, useful for nested objects :)
$scope.$watch('myConfig', function(newValue, oldValue) {
    console.log('myConfig changed !', newValue);
}, true)
```

### Two way data binding attribute without explicit scope declaration.
Sometimes you need to access a directive attribute with a two-way data binding without declaring it explicitely in the directive scope configuration. You can do this using the `$parse` service. 

If the scope would be isolated (`scope: {}`) then you'd have to use `scope.$parent` instead of $scope.

{% jsfiddle p2cjt js,html,result light 500px %}

### Use a callback function with arguments in your directive
To call a function defined in one of your attribute, declare it in the scope with `&`.

If you need to pass arguments, you must execute the callback using an object form for the arguments. AngularJS then call the function with your arguments in the correct order comparing your object and the callback declaration.

The following example also demonstrates how to watch multiples values at once.
{% jsfiddle HnrV7 js,html,result light 500px %}

### Custom transclusion

This example shows how to define a custom transclusion function and control its scope.

{% jsfiddle pHZNY js,html,result light 400px %}

### Announcer/Notifier pattern

If you need to listen to DOM objects creation/deletion, you can simply create a 'notifier' directive and an 'announcer' directive that you'll add to the objects you want to monitor. That directive will announce new instances creation (link function called) and destruction (`scope.$destroy` called).

It can be useful if you want to monitor arbitrary objects lifecycles, for example a `ng-repeat`. The 'announcement' can be made via events, or better, using a custom notifier controller. All credits goes to @garanajpr for the ideas.

{% jsfiddle 4ULCS js,html,result light 400px %}


Many more tricks to come, stay tuned :)

