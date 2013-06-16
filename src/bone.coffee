# The MIT License (MIT)
# 
# Copyright (c) 2013 Alytis
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

hyperbone.Bone = class Bone
  models: {}
  collections: {}

  service: null

  registry:
    communicationType: 'cors'

  constructor: (@originalOptions) ->
    _.extend @, Backbone.Events
    _.extend @registry, @originalOptions

    @parseOptions()

    if @originalOptions.autoDiscover? and @originalOptions.autoDiscover is true
      @originalOptions.discover()

  parseOptions: =>
    @registry.communicationType = @registry.communicationType.toLowerCase()

    @service = new @registry.serviceType @

  discover: ->
    @request @registry.root,
      success: @service.discoverResources

  url: (url) ->
    @service.url url

  request: (url, options) =>
    # Wraps jQuery's ajax call in order to automatically convert requests between
    # different communication types (IE, CORS or JSON-P) and generate URLs
    # when necessary.

    options = options or {}

    options.dataType = @registry.communicationType

    # TODO: Get this to use the HTTP standard Accept header, not ?format=json-p
    if @registry.communicationType == 'jsonp'
      options.crossDomain = options.crossDomain or true

    @service.request url, options

