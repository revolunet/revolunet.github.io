---
layout: post
title: Object-oriented AngularJS factories
date: 2014-02-14 00:00
comments: true
categories: AngularJS
author: Julien Bouquillon
---

Javascript prototypal inheritance can be confusing at first if you come from classical OOP languages, due to Javascript versatility, and the [variety](http://shichuan.github.io/javascript-patterns/#code-reuse-patterns) of [Javascript](http://addyosmani.com/resources/essentialjsdesignpatterns/book/#prototypepatternjavascript) [OOP](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Inheritance_and_the_prototype_chain) [patterns](http://howtonode.org/prototypical-inheritance) [available](http://javascript.info/tutorial/oop). Combined with the new service and factory concepts introduced in AngularJS, implementing OOP in your applications can lead to serious headaches, so i'll try to show you some solutions here.

If you need a step-by-step explanation of the Javascript prototypal inheritance, you can read the great [Dr. Axel Rauschmayer JavaScript inheritance by example](http://www.2ality.com/2012/01/js-inheritance-by-example.html) article.

Once your app grow and your services multiply, you'll quickly feel the need to **reuse your code**, and to split it in small modules to be able to separate concerns and setup some serious unit testing.

In this post, i'll show how to create a base AngularJS service, based on the Github API, that we'll be able to extend and reuse in different scenarios. We'll also leverage the power of promises chaining to extend the server responses and add additional data before returning the final result.

Something important to note here is that `factories` are useful to define our classes that you can instantiate many times (with the `new` keyword), while `services` always create singletons.


### Create our base service

Our first service will be responsible of fetching Github basic user data and return the result. We'll use a `factory` instead of a `service`, which will make it easier to instantiate many versions of the service in our application.

```js
app.factory('SimpleGithubUser', function($http) {

    var apiUrl = 'https://api.github.com/';

    // instantiate our initial object
    var SimpleGithubUser = function(username) {
        this.username = username;
        this.profile = null;
    };

    // define the getProfile method which will fetch data
    // from GH API and *returns* a promise
    SimpleGithubUser.prototype.getProfile = function() {

        // Generally, javascript callbacks, like here the $http.get callback,
        // change the value of the "this" variable inside it
        // so we need to keep a reference to the current instance "this" :
        var self = this;

        return $http.get(apiUrl + 'users/' + this.username).then(function(response) {

            // when we get the results we store the data in user.profile
            self.profile = response.data

            // promises success should always return something in order to allow chaining
            return response;

        });
    };
    return SimpleGithubUser;
})
```

So we can now easily inject our factory anywhere and use it like this :
```js
// we first inject our factory
app.controller('MyCtrl', function(SimpleGithubUser) {
    // instantiate a new user
    var user = new SimpleGithubUser('substack');
    // fetch data and publish on scope
    user.getProfile().then(function() {
        $scope.userLogin = user.profile.login;
    })
});

```

### Extending the base service

Now we'd like to attach some additional data to our users. Instead of modiying the original factory, or even worse, duplicate it, we can create another factory that extends the original one, just by using the regular javascript prototypal inheritance. We'll override some methods and use promises chaining to deliver the final data only when all the subsequent requests have been completed.

This has the advantage of encapsulating the logic inside the new service, making it easily testable while keeping your controllers light.

In this example we'll add some data from the Github events API and attach it to the user profile before returning the final result.

```js

// we define a new factory and inject our original service so we can extend it properly
app.factory('AdvancedGithubUser', function($http, SimpleGithubUser) {

    var apiUrl = 'https://api.github.com/';

    // create our new custom object that reuse the original object constructor
    var AdvancedGithubUser = function() {
        SimpleGithubUser.apply(this, arguments);
    };

    // reuse the original object prototype
    AdvancedGithubUser.prototype = new SimpleGithubUser();

    // define a new internal private method for this object
    function getUserEvents() {
        var self = this;
        return $http.get(apiUrl + 'users/' + this.username + '/events').then(function(response) {

            // attach the events API result to our user profile
            self.profile.events = response.data;

            // promises should always return a result
            return response;
        });
    }

    // Now let's override our original getProfile method
    AdvancedGithubUser.prototype.getProfile = function() {

        var self = this;

        // we first call the original getProfile method (aka super method)
        var originalGetProfile = SimpleGithubUser.prototype.getProfile.apply(this, arguments);

        // we use promises chaining to add additional data
        return originalGetProfile.then(function() {

            // before returning the result,
            // call our new private method and bind "this" to "self"
            // we need to do this because the method is not part of the prototype
            return getUserEvents.call(self);
        });
    };
    return AdvancedGithubUser;
});
```

Usage is exactly the same, except the service added the events data for us :
```js
// we first inject our factory
app.controller('MyCtrl', function(AdvancedGithubUser) {
    // instantiate a new user
    var user = new AdvancedGithubUser('substack');
    // fetch data and publish on scope
    user.getProfile().then(function() {
        $scope.userEvents = user.profile.events;
    })
});

```

### Create a service instance

Now that you have some solid factories, you can also instantiate some app-wide services that expose pre-configured instances.

```js
app.service('MyUserProfile', function(AdvancedGithubUser) {
    var user = new AdvancedGithubUser('revolunet');
    user.getProfile();
    return user;
});

```
And use it like this :
```js
app.controller('MyCtrl', function(UserProfile) {
    $scope.user = MyUserProfile;
    alert(MyUserProfile.location);
})
```

## Final result
{% jsfiddle YLs26 result,html,js,css light 600px %}


Hope this has been useful to you, please ask below or on twitter [@revolunet](http://twitter.com/revolunet) for any question/suggestion :)
