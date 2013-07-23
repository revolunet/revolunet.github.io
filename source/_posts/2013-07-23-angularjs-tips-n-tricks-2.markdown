---
layout: post
title: AngularJS tips'n'tricks part 2
date: 2013-07-23 00:00
comments: true
categories: AngularJS
author: Julien Bouquillon
---

Here's a new batch of AngularJS tips and gotchas; If you didn't read it yet, you can check the [part 1](http://blog.revolunet.com/blog/2013/05/01/angular-tips-n-tricks/) and feel free to comment below :)

### Access an element scope from outside

This is useful for debugging: in your Chrome console, hightlight a node in the Elements tab, then, in the console, to check its scope :

```js
angular.element($0).scope();
```
or even :
```js
angular.element(document.getElementById('elementId')).scope();
```

The [Batarang Chrome Extension](https://chrome.google.com/webstore/detail/angularjs-batarang/ighdmehidhipcmcojjgiloacoafjmpfk?utm_source=chrome-ntp-icon) is much powerful and let you inspect any scope, anywhere :)

### Unwatch an expression

Sometimes you want to watch an expression only a few times, and then forget it. The `$watch` function returns a callback just for that. You just have to execute it back to destruct the watcher.

```js
var watcher = $scope.$watch('data.counter', function(newValue, oldValue) {
    iElement.css('width', 50 * newValue + 'px');
    if (newValue >= 10) {
        // when data.counter reaches 10, destruct the watcher.
        watcher();
    }
});
```

### Group elements in a select

If you play with selects, the `ng-options` directive is [quite powerful](http://docs.angularjs.org/api/ng.directive:select) and [has many syntaxes](http://odetocode.com/blogs/scott/archive/2013/06/19/using-ngoptions-in-angularjs.aspx).

For example you can easily group a model by attribute :

```html
<select ng-options="distrib.version group by distrib.name for distrib in distribs"></select>
```

Of course, just add an `ng-model` directive to your select to data-bind it to one of the values.

### Filter falsy values

You can't use the builtin filter for falsy attributes or values :/ I don't know if this is a bug of feature, but a simple workaround is to use a custom filter function that you can expose on the scope. (you can also define your own filter).

```js
$scope.testValues = ['a', 'b', 'c', false, true, 0, -1, 5, 42];
$scope.isFalsy = function(val) {
  return !val;
}
```
{% raw %}
```html
{{ testValues|filter:true }}        //  [true]
{{ testValues|filter:5 }}           //  [5]
{{ testValues|filter:0 }}           //  ['a', 'b', 'c', false, true, 0, -1, 5, 42]
{{ testValues|filter:false }}       //  ['a', 'b', 'c', false, true, 0, -1, 5, 42]
{{ testValues|filter:isFalsy }}     //  [false, 0]
```
{% endraw %}


### Filter on objects

The builtin filter function is [quite powerful](http://code.angularjs.org/1.1.5/docs/api/ng.filter:filter) and allows you to filter a list of objects on given properties only, or on everything, exactly or not, negated or not, etc...

{% raw %}
```html
{{ games|filter:'street' }}                       //  all games containing "street" in any property
{{ games|filter:'!street' }}                      //  all games NOT containing "street" in any property
{{ games|filter:{name:'street'} }}                //  all games containing "street" in their name
{{ games|filter:{name:'street'}:true }}           //  all games named exactly "street"
{{ games|filter:{name:'street', device:'PS3'} }}  //  all games containing "street" in their name and PS3 in their device
```
{% endraw %}

### ng-repeat with duplicate items

If for some reason you need to have duplicate items in your `ng-repeat` you can extend your `ng-repeat` expression with `track by $index` and it works :)

### Directive : parse attribute without watching it

In one of your directive, if you need to have a read-only access to an attribute model, but without the automatic watch/binding, you can simply use `&` instead of `=` when declaring the binding in the scope. You'll then be able to access the model value . (this may break in future releases). This is a shortcut for using the `$parse` service on the current scope.

```js
app.directive('rnCounter', function() {
  return {
    scope: {
      count: '&rnCounter'
    },
    link:function(scope, iElement) {
      iElement.bind('click', function() {
        console.dir(scope.count());
      })
    }
  }
})
```

### Data-binding to a boolean

You can bind to a boolean value, but you **can't** update that value from your directive.

This won't work :
```html
<div rn-zippy status="true"></div>
```

```js
app.directive('rnZippy', function() {
  return {
    restrict: 'A',
    scope: {
      status: '=?'
    },
    link: function(scope, iElement) {
      function toggle () {
        scope.$apply(function() {
          scope.status = !scope.status;  
        });
      }
      iElement.bind('click', toggle);
    }
  }
})
```


You need to use a real model, OR, initialise a new one and use it as your model instead :
```html
<div rn-zippy ng-init="status=true" status="status"></div>
```

### Includes onload

You can trigger a callback when your `ng-include` partial is loaded :
```html
<div ng-inlude="'partials/' + page + '.html'" onload="callback()"></div>
```

For the `ngView`, you need to listen to the `$viewContentLoaded` event.


That's all for today, feel free to ask and comment below :)
