Hyperbone
=========

HyperBone provides interfaces for easily exposing, discovering, and
understanding APIs consistently with [Backbone][bb].

HyperBone consists of a "Bone", which acts as an intermediate adapter which
uses plugins to translate APIs into backbone models. When you instantiate a
bone and give it a plugin, HyperBone will take over from there by providing you
models and collections for making use of the API represented by your plugin.

With schema-based, versioned, RESTful APIs, HyperBone makes your boilerplate
for representing APIs extremely minimal. With the provided code and a driver
that performs discovery, you will end up with every resource in the API
represented as [Backbone][bb] [Model][md]s and [Collection][cl]s.



[bb]: http://backbonejs.com "Backbone.JS"
[md]: http://backbonejs.org/#Model "Backbone.JS - Model"
[cl]: http://backbonejs.org/#Collection "Backbone.JS - Model"

