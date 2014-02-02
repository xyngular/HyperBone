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


class Bone
  models: {}
  collections: {}

  service: null

  registry:
    communicationType: 'cors'

  constructor: (options) ->
    _.extend @, Backbone.Events

    @originalOptions = _.extend {}, options

    @registry = _.extend @registry, @initialize options
    @service = @createService()

    if @registry.autoDiscover is true
      @originalOptions.discover()

  initialize: (options) -> options

  createService: -> new @registry.serviceType @

  discover: ->
    @request @registry.root,
      success: @service.discoverResources

  url: (url) ->
    @service.url url

  request: (url, options) ->
    options = _.extend {}, options,
      dataType: @registry.communicationType.toLowerCase()

    # TODO: Get this to use the HTTP standard Accept header, not ?format=json-p
    if options.dataType.toLowerCase() == 'jsonp'
      options.crossDomain ?= true

    @service.request url, options


module.exports = {Bone}
