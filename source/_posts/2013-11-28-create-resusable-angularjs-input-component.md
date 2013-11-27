---
layout: post
title: Create a reusable AngularJS input form component
date: 2013-11-28 00:00
comments: true
categories: AngularJS
author: Julien Bouquillon
---

One of the beauty of the AngularJS framework is its ability to isolate complexity with services and directives; This is perfect for segmenting our code, create very testable components, and make them reusable. A directive, which is an anticipation of the future [web components](http://css-tricks.com/modular-future-web-components/), is a piece of isolated javascript, HTML and CSS that encapsulate a specific behaviour and that you can easily reuse in various apps. Once created, a directive is simply invoked by adding it to the DOM via a HTML tag (`<accordion></accordion>`, or a custom attribute `<div accordion></div>`, or a CSS class `<div class="accordion"></div>` (and even as HTML comment).

In this tutorial we'll go through the creation of a custom stepper directive that can be used as a reusable input component in your applications. We'll cover the classic directive creation but also the input validation, and the use of the [ngModelController](http://docs.angularjs.org/api/ng.directive:ngModel.NgModelController), that will allow a seamless integration with any form, leveraging the existing AngularJS forms superpowers. The next part will cover the use of grunt, the test suites with Jasmine and KarmaJS, and the publication and distribution of our widget with GitHub and bower.

For this example we'll build a custom numeric input widget, named "rn-stepper". We'll use the last AngularJS 1.2 that brings some important fixes to the private scopes management (capital point for reusable components). The full widget code is [available on github](https://github.com/revolunet/angular-stepper) as a reusable component and you can see the final result here : 

{% jsfiddle 26ghx result,js,html,css light 250px %}


### Markup generation

The first step is to create a naïve directive that build our markup, and renders correctly. We just declare the directive name, and template to use.

```javascript
// we declare a module name for our projet, and its dependencies (none)
angular.module('revolunet.stepper', [])
// declare our naïve directive
.directive('rnStepper', function() {
    return {
        // can be used as attribute or element
        restrict: 'AE',
        // which markup this directive generates
        template: '<button>-</button>' +
                  '<div>0</div>' +
                  '<button>+</button>'
    };
});
```
Now, to use our directive, its quite straightforward :

 - declare our `revolunet.stepper` module as one of our app dependencies
 - use `<div rn-stepper></div>` (attribute form) or simply `<rn-stepper></rn-stepper>` (element form). to integrate the directive somewhere.

The attribute form is better if you want to support IE8 as it works out-of-the-box.

demo : [http://jsfiddle.net/revolunet/n4JHg/](http://jsfiddle.net/revolunet/n4JHg)

### Add internal behaviour

Now we need to add behaviour and internal variables to our custom component. We'll declare a "private scope" that will hold internal variables and functions, and add the `link` function to our directive, which is responsible of initialising the component behaviour just after the markup has been inserted in the final page.

Here's the updated directive code :

```javascript
.directive('rnStepper', function() {
    return {
        restrict: 'AE',
        // declare the directive scope as private (and empty)
        scope: {},
        // add behaviour to our buttons and use a variable value
        template: '<button ng-click="decrement()">-</button>' +
                  '<div>{{ value }}</div>' +
                  '<button ng-click="increment()">+</button>',
        // this function is called on each rn-stepper instance initialisation
        // we just declare what we need in the above template
        link: function(scope, iElement, iAttrs) {
            scope.value = 0;
            scope.increment = function() {
                scope.value++;
            }
            scope.decrement = function() {
                scope.value--;
            }
        }
    };
});
```

We now have a functionnal component with an isolated code and template.

demo : [http://jsfiddle.net/revolunet/A92Aw/](http://jsfiddle.net/revolunet/A92Aw/)

### Communicate with the external world

Our component works great but it would be more useful if it could control a real public variable, known as a `ngModel` in AngularJS.

Let's add a databinding between our component internal `value` and the outer world (our application).

We just need to update our scope declaration like this :

```javascript
scope: {
    value: '=ngModel'
}
```
This will automagically bind our internal `value` variable to the external one declared in the `ngModel` attribute. The `=` means "double data-binding" which means if ngModel is updated externally then the internal `value` will be updated, and vice-versa.

Say my app expose a `rating` variable, we could now bind it to our component simply like this :

```html
<div rn-stepper ng-model="rating"></div>
```

demo : [http://jsfiddle.net/revolunet/9e7Hy/](http://jsfiddle.net/revolunet/9e7Hy/)

### Make our component form-friendly

We now have a dynamic input that can manipulate arbitrary ngModel data. We need to modify a bit the code to make it play nice with the AngularJS forms. For example, AngularJS forms and input generally expose a `$pristine` and `$dirty` state which can be useful in many situation. To make the forms aware of our model changes from inside our component, we need to make use of the `ngModelController.$render` and `ngModelController.$setViewValue` API methods, which are available **as soon as you "require" a ngModel** on your directive.

The `ngModelController.$render` method is a method which you should override yourself in the directive and is responsible of updating the view; it will be called by the framework when the external ngModel changes. When the model changes, the framework executes the `$formatters` pipeline which is responsible of eventually converting the `$modelValue` raw value to a usable `$viewValue`.

For example, if your model is a real Date object, you'd want your input to display it as dd/mm/YY. The model-to-view conversion is made by the `$formatters` pipeline and the view-to-model by the `$parsers` pipeline. Once you get a ngModelController instance, you can easily insert new items in these pipelines.

The `ngModelController.$setViewValue` method should always be called when you want update a model from your directive (view). It takes care of calling the eventual `$parsers` pipeline. Then it applies the final value to the internal $modelValue, update the input $dirty state, update the optional parent form $dirty state and call any registered `$viewChangeListeners`. Here's the [full code for this function](https://github.com/angular/angular.js/blob/a090400f09d7993d102f527609879cdc74abae60/src/ng/directive/input.js#L1140-L1166).

As pointed by a comment from [@ThomasBelin4](http://twitter.com/@ThomasBelin4) below, we don't need anymore to have a scope `value` variable, as we now have a reference to the original `ngModelController` which holds a reference to the viewValue.

Here's how we update the directive declaration :

```javascript
.directive('rnStepper', function() {
    return {
        // restrict and template attributes are the same as before.
        // we don't need anymore to bind the value to the external ngModel
        // as we require its controller and thus can access it directly
        scope: {},
        // the 'require' property says we need a ngModel attribute in the declaration.
        // this require makes a 4th argument available in the link function below
        require: 'ngModel',
        // the ngModelController attribute is an instance of an ngModelController
        // for our current ngModel.
        // if we had required multiple directives in the require attribute, this 4th
        // argument would give us an array of controllers.
        link: function(scope, iElement, iAttrs, ngModelController) {
            // we can now use our ngModelController builtin methods
            // that do the heavy-lifting for us

            // when model change, update our view (just update the div content)
            ngModelController.$render = function() {
                iElement.find('div').text(ngModelController.$viewValue);
            };

            // update the model then the view
            function updateModel(offset) {
                // call $parsers pipeline then update $modelValue
                ngModelController.$setViewValue(ngModelController.$viewValue + offset);
                // update the local view
                ngModelController.$render();
            }

            // update the value when user clicks the buttons
            scope.decrement = function() {
                updateModel(-1);
            };
            scope.increment = function() {
                updateModel(+1);
            };
        }
    };
});
```

demo : [http://jsfiddle.net/revolunet/s4gm6/](http://jsfiddle.net/revolunet/s4gm6/)

### Add min/max attributes

Now our component is form-friendly, so let's as some builtin validation rules.

We could add optional min/max attributes to our component, which will handle the form validation by himself when they are present. These attributes will be data-bound so they can be updated at any time by the application (some other inputs in a form may impact the min/max here).

The `ngModelController` API gives us also a `$setValidity` method that can inform the parent forms about our component validity, and automatically add some handy CSS classes related to validity to out form and inputs.

We just need to call `ngModelController.$setValidity('outOfBounds', false)` to make our input, and thus parent forms invalids, and have `ng-invalid` and `ng-invalid-out-of-bound` CSS classes added to our forms and to our component.

Our stepper component is now full functionnal and integrates seamlessly in any form.

demo: [http://jsfiddle.net/revolunet/HCUNC/](http://jsfiddle.net/revolunet/HCUNC/)

### Prevent invalid input

Another nice-to-have feature would be to prevent the user from entering invalid data, which means disabling the buttons when the internal value reach the min/max limits. This could be achieved in two ways :

 - BAD :  manually in our link function, toggling our buttons states on each click.
 - GOOD : automagically, using a builtin `ng-disabled` directive in our template, that will disable the buttons under some conditions.

The second option is much more Angular-ish and there are several ways to achieve this so let's see how we can do.

We can add `ng-disabled="isOverMin()"` to our first button template and add a `scope.isOverMin` function that returns a boolean indicating if we should disable or not the given button. same with `overMax` that would check if the max has been reached or not.

Our template is now :
{% raw %}
```html
<button ng-disabled="isOverMin()" ng-click="decrement()">-</button>
<div>{{ value }}</div>
<button ng-disabled="isOverMax()" ng-click="increment()">+</button>
```
{% endraw %}

demo : [http://jsfiddle.net/revolunet/26ghx/](http://jsfiddle.net/revolunet/26ghx/)


The next part will detail the tests suite and distribution subjects over github and bower.

Stay tuned :) and feel free to comment/ask below !


