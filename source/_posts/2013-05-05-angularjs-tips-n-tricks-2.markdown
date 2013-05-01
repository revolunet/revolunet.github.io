---
layout: post
title: AngularJS tips'n'tricks part 2
date: 2013-05-5 00:00
comments: true
categories: AngularJS
author: Julien Bouquillon
published: false
---

If you didn't read it yet, please check the part 1

### Various

**normalized attributes** : From your directive link or compile function, the `iAttrs` or `tAttrs` objects gives you normalized attributes. This means if you have a `data-rn-carousel-index` or  `rn-carousel-index` attribute, you'll always get a `rnCarouselIndex` key.

