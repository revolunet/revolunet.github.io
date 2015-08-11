---
layout: post
title: Unit testing an AngularJS directive
date: 2013-12-05 00:00
comments: true
categories: AngularJS
author: Julien Bouquillon
---

In this article, i'll detail the process to unit test the stepper directive we've created in the last week [custom component creation article](http://blog.revolunet.com/blog/2013/11/28/create-resusable-angularjs-input-component/). Next week, i'll cover how to distribute your component via GitHub and Bower.

Unit testing is the art of testing individually every smallest part of your code, which are the foundations of your apps sanity. Once correctly tested, these parts assembled together will also play nicely, as their behaviour has already been validated independently.

Unit testing helps you **prevent regressions, increase quality, maintenability, and trust in your codebase**, thus better team collaboration, easier refactoring... and WIN :)

Another usage is, when you get a new bug report, you add the revelant test that demo the bug, fix it in your code so the test will pass, then keep it there as a proof of reliability.

Among AngularJS best friends there is the [KarmaJS test runner](http://karma-runner.github.io) (A nodeJS server to launch the tests in browsers and reports the results) and the [Jasmine behaviour-driven testing framework](http://pivotal.github.io/jasmine/) (the language to define your tests and expectations). We'll use the grunt-karma task to integrate karma in our classic yet awesome grunt workflow and launch the tests in our browsers. Note that karma can run the tests in remote cloud browsers, for example via [SauceLabs](http://saucelabs.com/) or [BrowserStack](http://www.browserstack.com/).

**AngularJS is made from ground-up for testing, so make yourself a favor, start NOW :)**

## Glossary

There are some terms that may need clarification before we go further :

 - `spec` : the specifications of something you want to test, consisting one or many tests suites. should cover all the expected behaviour.
 - `test suite` : This is a group of tests; defined within a `describe` block in Jasmine. blocks can be nested as much as needed.
 - `test` : Test instructions, that ends with one or more expectations; defined within a `it` block in Jasmine.
 - `actual` : this is the value you test in your expectation.
 - `expected value` : this is the value you test the actual value against.
 - `matcher` : A function that compares the `actual` and the `expected` values and returns a boolean success result to Jasmine. eg : `toEqual`, `toBeGreatherThan`, `toHaveBeenCalledWith`... you can even define your owns.
 - `expectation` : Use the expect function to test a value, called the actual. It is chained with a matcher function, which takes the expected value.
 - `mock` : a stubbed service that replace a real one at runtime with fake data/methods that you can control during your tests.

Here's an example spec file :

```javascript
// a test suite (group of tests)
describe('sample component test', function() {
    // a single test
    it('ensure addition is correct', function() {
        // sample expectation
        expect(1+1).toEqual(2);
        //                  `--- the expected value (2)
        //             `--- the matcher method (equality)
        //       `-- the actual value (2)
    });
    // another test
    it('ensure substraction is correct', function() {
        expect(1-1).toEqual(0);
    });
});
```

## Setup the test environnement

#### Add grunt-karma to your project dependencies
```bash
npm install grunt-karma --save-dev
```

#### Create karma-unit.js file

[Here is our full example](https://github.com/revolunet/angular-stepper/blob/master/karma-unit.js). This file defines :

 - the javascript files to be loaded in the browsers for the tests. Typically, this is the libraries you use, your application files, but also the files for your tests and the eventuals mocks.
 - which browsers to run the tests against.
 - how to reports the results : console, browser... ?
 - optional plugins.

Here's our example "files" section : 

```javascript
files: [
  "http://code.angularjs.org/1.2.1/angular.js",       <-- angular source
  "http://code.angularjs.org/1.2.1/angular-mocks.js", <-- angular mocks & test utils
  "src/angular-stepper.js",                           <-- our component source code
  "src/angular-stepper.spec.js"                       <-- our component test suite
]
```

NB: One could add jquery here if it helps you write your test code (more powerful selectors, CSS tests, size computation...)

#### Add the karma grunt tasks to your Gruntfile.js
```javascript
karma: {
    unit: {
        configFile: 'karma-unit.js',
        // run karma in the background
        background: true,
        // which browsers to run the tests on
        browsers: ['Chrome', 'Firefox']
    }
}
```

Create `angular-stepper.spec.js` and paste the content of the sample test above. You can now simply run `grunt karma` and see your tests executing in the browsers and reporting the results in the console.

```bash
....
Chrome 33.0.1712 (Mac OS X 10.9.0): Executed 2 of 2 SUCCESS (1.65 secs / 0.004 secs)
Firefox 25.0.0 (Mac OS X 10.9): Executed 2 of 2 SUCCESS (2.085 secs / 0.006 secs)
TOTAL: 4 SUCCESS
```

Each dot represent a successfull test and you can see our two tests runs in the two browsers we've configured before in our karma-unit.js file. woot !

Now let's code the real tests :)

## Code our directive unit tests

Our component unit test suite, aka the *spec* should cover all the expected behaviour of our component, but also test the edge cases (eg : invalid input, unexpected server behaviours...)

Below you can see an extract of our angular-stepper component test suite (angular-stepper.spec.js), and [here's the full spec](https://github.com/revolunet/angular-stepper/blob/master/src/angular-stepper.spec.js). Our tests for such a component are quite simple, no need for mocks here. The only tricky thing is that we wrap our directive inside a form to be able to test that it plays well with ngModelController and updates form validity correctly.

```javascript
// the describe keyword is used to define a test suite (group of tests)
describe('rnStepper directive', function() {

    // we declare some global vars to be used in the tests
    var elm,        // our directive jqLite element
        scope;      // the scope where our directive is inserted

    // load the modules we want to test
    beforeEach(module('revolunet.stepper'));

    // before each test, creates a new fresh scope
    // the inject function interest is to make use of the angularJS
    // dependency injection to get some other services in our test
    // here we need $rootScope to create a new scope
    beforeEach(inject(function($rootScope, $compile) {
        scope = $rootScope.$new();
        scope.testModel = 42;
    }));

    function compileDirective(tpl) {
        // function to compile a fresh directive with the given template, or a default one
        // compile the tpl with the $rootScope created above
        // wrap our directive inside a form to be able to test
        // that our form integration works well (via ngModelController)
        // our directive instance is then put in the global 'elm' variable for further tests
        if (!tpl) tpl = '<div rn-stepper ng-model="testModel"></div></form>';
        tpl = '<form name="form">' + tpl + '</tpl>';
        // inject allows you to use AngularJS dependency injection
        // to retrieve and use other services
        inject(function($compile) {
            var form = $compile(tpl)(scope);
            elm = form.find('div');
        });
        // $digest is necessary to finalize the directive generation
        scope.$digest();
    }

    describe('initialisation', function() {
        // before each test in this block, generates a fresh directive
        beforeEach(function() {
            compileDirective();
        });
        // a single test example, check the produced DOM
        it('should produce 2 buttons and a div', function() {
            expect(elm.find('button').length).toEqual(2);
            expect(elm.find('div').length).toEqual(1);
        });
        it('should check validity on init', function() {
            expect(scope.form.$valid).toBeTruthy();
        });
    });

    it('should update form validity initialy', function() {
        // test with a min attribute that is out of bounds
        // first set the min value
        scope.testMin = 45;
        // then produce our directive using it
        compileDirective('<div rn-stepper min="testMin" ng-model="testModel"></div>');
        // this should impact the form validity
        expect(scope.form.$valid).toBeFalsy();
    });

    it('decrease button should be disabled when min reached', function() {
        // test the initial button status
        compileDirective('<div rn-stepper min="40" ng-model="testModel"></div>');
        expect(elm.find('button').attr('disabled')).not.toBeDefined();
        // update the scope model value
        scope.testModel = 40;
        // force model change propagation
        scope.$digest();
        // validate it has updated the button status
        expect(elm.find('button').attr('disabled')).toEqual('disabled');
    });
    // and many others...
});
```

**Some notes :**

 - A directive needs to be compiled in a given scope to be tested
 - A non-isolated scope can be acceded via element.scope()
 - An isolated scope can be acceded via element.isolateScope()
 
**Why to we have to call `scope.$digest()` when we change a model value in the tests ?**

In a real angular app, the `$digest` is automatically triggered by the framework in reaction to various events (clicks, inputs, requests...). There's no such user-based events during the automated tests so we just need to force the `$digest`. (the `$digest` is what update all the bindings).

## Bonus #1: real time tests

Thanks to grunt, we can make the tests run when the source changes and be alerted in real time.

If you want the tests to be run on each code change, just add a section to your `watch` task :

```javascript
js: {
    files: ['src/*.js'],
    tasks: ['karma:unit:run', 'build']
},
```

You could update your default grunt task like this
```javascript
grunt.registerTask('default', ['karma:unit', 'connect', 'watch']);
```
Now, just run `grunt` and you'll get real-time tests and a builtin webserver :)

## Bonus #2: add code coverage reporting

As developers, we love solid metrics; and we also love continous improvements. "coverage" refers to the code coverage of your test suite; It gives you metrics and detailed info to increase your code coverage without pain.

Here's a sample coverage HTML report :

{% img center /images/coverage-example.png 600 283 AngularJS test coverage report example %}

We can see, for each folder and file, how much code is covered by our test suite. And this is updated in real-time thanks to grunt+karma integration. For each file, we can see line by line which blocks stays untested, which makes writing the remaining tests more straightforward.

**100% test coverage doesnt mean your code is bug-free, but it increase quality for sure !**

Its really easy to integrate this in our karma+grunt setup. Karma has a "plugin" system that allows you to plug the fantastic [Istanbul code coverage tool](https://github.com/gotwarlost/istanbul) so we just need to configure the karma-unit.js file and we're done :)

#### Add coverage to karma

```bash
# add the necessary node_modules
npm install karma-coverage --save-dev
```

now update the karma config file with these new settings :
```javascript
// here we specify which of the files we want to appear in the coverage report
preprocessors: {
    'src/angular-stepper.js': ['coverage']
},
// add the coverage plugin
plugins: [ 'karma-jasmine', 'karma-firefox-launcher', 'karma-chrome-launcher', 'karma-coverage'],
// add coverage to reporters
reporters: ['dots', 'coverage'],
// tell karma how you want the coverage results
coverageReporter: {
  type : 'html',
  // where to store the report
  dir : 'coverage/'
}
```

More coverage config options here : [https://github.com/karma-runner/karma-coverage](https://github.com/karma-runner/karma-coverage)

You now need to run your tests again to generate your first report. It should be located in the project root "coverage" folder.

**Feel free to comment/ask below :)**

Next week, we'll talk about distributing our now well tested directive on Github and Bower :)
