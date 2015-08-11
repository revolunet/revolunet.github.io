---
layout: post
title: Universal .htaccess CORS support
date: 2013-10-03 00:00
comments: true
categories: apache javascript
author: Julien Bouquillon
---

## What is CORS

In the internet AJAX early days (~2000) browsers vendors implemented a strict cross-domain communication policy that prevented javascript on a given page to communicate with third party domains. Many workarounds have been implemented since, like JSONP, which is only a 'hack' allowing cross-domain communication using javascirpt callbacks; Handy, but this prevents any other method than GET and forces the use of querystring to pass parameters.

With the RISE of internet APIs and decentralised services, having a way to communicate with 3rd party domain became critical; thus, the [W3C defined the CORS](http://www.w3.org/TR/cors/) protocol, acronym which stands for "Cross-Origin Resource Sharing" and allows different domains to communicate together, the same way Adobe Flash did it a long time before with the crossdomain.xml policy (remember?).

Now with CORS, the server defines which domains (applications) can communicate with him (or anyone). When CORS is enabled on the server, your javascript can communicate transparently using any HTTP method; For non-GET requests, the browser transparently make an initial OPTIONS request to check if the request is allowed or not, and then makes the real request.

## CORS-enable your API

You can find the whole specs and various implementations at [enable-cors.org](http://enable-cors.org/).

## Pain-free CORS for Apache servers

If you don't want to change your code, we've crafted a small .htaccess for you that will force CORS on your API, without even touching your code. Just drop one of the implementations in your .htaccess and your API is magically CORS-enabled :)

{% gist 6295643 %}

Note: If you use the withCredentials version, be sure to add `withCredentials: true` in your AJAX requests.

You can validate your API CORS support using this demo : [http://embed.plnkr.co/1E8ot9e1eVs23IrjzqKr/preview](http://embed.plnkr.co/1E8ot9e1eVs23IrjzqKr/preview)

Hope this helps !




