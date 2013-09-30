---
layout: post
title: Extending the Topcoat CSS framework
date: 2013-09-30 00:00
comments: true
categories: css javascript phonegap
author: Julien Bouquillon
published: false
---

## Introduction

[Topcoat.io](http://topcoat.io) is the new kid on the block of the CSS frameworks. It's the first one that's built for performance from the ground up, thanks to the constant performance tracking using Chrome telemetry, which makes it a tool of choice to build your mobile applications UI. Its also pure CSS, so its easy to integrate with any Javascript framework.

Topcoat has been built for the future, thanks to solid conventions and a cutting-edge javascript architecture, and more goodness :

 - [BEM syntax](http://csswizardry.com/2013/01/mindbemding-getting-your-head-round-bem-syntax/) convention
 - [stylus](http://learnboost.github.io/stylus/) CSS preprocessor
 - [grunt](http://gruntjs.com) task automation
 - [TopDoc](https://github.com/topcoat/topdoc) CSS documentation generator
 - [npm](http://npmjs.org) for dependencies

It's fully open source, not "fauxpen source", and the contributors uses various online tools to run the project :
 
 - [Github](http://github.com/topcoat) of course for code and issues
 - [codepen.io](http://codepen.io/Topcoat) to prototype and host widgets demos
 - [huboard](http://huboard.com/topcoat/topcoat) to manage milestones on top of Github issues

All of this make it a powerful framework made to be extensible and performant.

## Install topcoat

Just [download the latest release](https://github.com/topcoat/topcoat/releases) from github and extract it. The release contains the final CSS with dark and light themes for desktop and mobile, so you can use then directly; just add a link to the `topcoat-mobile-light.min.css` file in your app for example.

If you want to customize the themes or add new components, you need to run `npm install` from the topcoat folder. This will download all the widgets sources and local dependencies to your `node_modules` folder.

Some important things to notice :

 - Each component (button, list, checkbox...) has its own folder in the `node_modules` subfolder (so each one has its own npm repo). Each one also has its own gruntfile in case you want to build its css separately.
 - Most of components have a `topcoat-[COMPONENT]-base` folder with just enough CSS to completely reset the styling of the element, so other components can override it entirely. For example the default button hasn't any default border or background and looks like a simple text block; 
 - The `topcoat-theme` folder defines the 4 builtin topcoat themes which are just a combination of variables that defines some variations of the components.
 - The main Gruntfile list the available themes and associated widgets using pattern globbing and this is from where the final CSS are built, including the given widgets.

## Adding a custom theme

You can easily tweak the builtin themes by modifying the variables inside the `topcoat-theme` folder then run `grunt` to rebuild the final CSS. But its much better to add your own theme and left the others untouched.

Let's add a simple green theme :

 - copy the `topcoat-theme/src/theme-topcoat-*` file from the theme that matches the most your design, eg copy `theme-topcoat-mobile-light.styl` to `theme-green.styl`.
 - create a `variables-green.styl` with a bunch of variables that override the default ones (see the list of variables in the other variables-* files). For example :

```js
// base colors
var-color = #00b400
var-background-color = #e2ffe2
var-placeholder-color--input = #4eff4e
var-background-color--down = #00b400
var-background-color--hover = #02ff01
var-border--focus = 1px solid #00b400
var-box-shadow--focus = 0 0 0 2px #00b400

// cta button colors
var-background-color--cta = #00b300
var-border--cta = 1px solid #006700
var-background-color--cta--down = #00b400
var-background-color--cta--hover = #02ff01
```

 - add `@import variables-green` to your `theme-green.styl`. (This allows you later to combine some variables files)
 - add the theme link in the main gruntfile, 'stylus' section:
```js
stylus: {
    green: {
        options: {
            import: ['theme-green', 'utils']
        },
        files: [{
            src: [
                // here you can eventually add/remove some components from the output
                'node_modules/topcoat-*/src/**/*.styl'
                ],
            dest: 'css/topcoat-green.css'
        }]
    }
}
```

 - Now run `grunt` and you'll see your final `topcoat-green.css` and  `topcoat-green.min.css` appear magically in the CSS folder :)
 - You also have a `demo/topcoat-green.html` file for free that show you the final result, generated via TopDoc.

## Add a custom component

Now, let's say you want to add a custom button to the generated theme, for example `button-round`.

Add a `node_modules/topcoat-button-round` folder and create `src/topcoat-button-round.styl` file. Inside, add your round button definition, with the documentation to generate the demo :

```css
// import anything you need to extend
@import topcoat-button
/* topdoc
  name: Round Button
  description: A simple, yet round button
  modifiers:
    :active: Round button active state
    :disabled: Disabled state
    :hover: Hover state
    :focus: Focused
  markup:
    <button class="topcoat-button--round">Button</button>
    <button class="topcoat-button--round" disabled>Button</button>
  tags:
    - desktop
    - light
    - mobile
    - button
    - round
*/
.topcoat-button--round {
    @extend .topcoat-button
    border-radius: 999px;
}

.topcoat-button--round:disabled {
  @extend .topcoat-button:disabled
}

.topcoat-button--round:hover {
  @extend .topcoat-button:hover
  text-shadow: var-text-shadow;
  box-shadow: var-box-shadow;
}

.topcoat-button--round:focus {
  @extend .topcoat-button:focus
}

.topcoat-button--round:active {
    color: var-color;
    text-shadow: var-text-shadow;
    background-color: var-background-color--down;
    box-shadow: var-box-shadow--down;
}
```

Now, when you'll run `grunt` again, the final CSS will include your button definition and the `demo/topcoat-green.html` demo page will present your new button with related documentation.

## Creating new Topcoat components

Now you know how to add custom components and integrate them in the topcoat workflow properly.

If you're willing to share new components with the community (and you should), here's the workflow :

 - demo your component markup and css on [codepen.io](http://codepen.io)
 - create a github repo for your component, using the same structure as any of the `node_modules/topcoat-*` folder.
 - if accepted, your component will be added to the main Topcoat `package.json` then auto-installed with `npm install`.

## Need help ?

Comment below, use Github issues or join the #topcoat irc channel to discuss :)


**I hope this quick intro will help you choose Topcoat as your next CSS framework and you will contribute to the project so we can build together a better CSS framework.**


