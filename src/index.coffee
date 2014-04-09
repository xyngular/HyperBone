amdExports = [
  'exports'
  'jquery',
  'underscore'
  'backbone'
]


setup = (root, factory) ->
  if typeof define is 'function' and define.amd
    define amdExports, (exports, jQuery, _, Backbone, relational) ->
      root.HyperBone = exports
      factory exports, jQuery, _, Backbone

  else if typeof exports is 'object'
    jQuery = require 'jQuery'

    _ = require 'underscore'
    Backbone = require 'backbone'

    factory exports, jQuery, _, Backbone

  else
    root.HyperBone = {}
    factory root.HyperBone, jQuery, root._, root.Backbone


setup @, (HyperBone, jQuery, _, Backbone) ->
  class AbstractionError extends Error
  class ConfigurationError extends Error


  naturalModelName = (modelName) ->
    parts = modelName
      .replace '-', '_'
      .replace ' ', '_'
      .split '_'

    natural = ''

    for part in parts
      upperPart = (part.charAt 0).toUpperCase() + part.substring 1
      natural += upperPart

    return natural


  naturalCollectionName = (resourceName) ->
    modelName = naturalModelName resourceName
    modelName + 'Collection'


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

      @registry.modelType ?= Backbone.Model
      @registry.collectionType ?= Backbone.Collection

      @service = @createService()

      if @registry.autoDiscover is true
        @originalOptions.discover()

    initialize: (options) -> options

    createModel: (modelName, endpoint) ->
      return @registry.modelType.extend
        urlRoot: endpoint
        bone: @

        relations: []

        parse: (response) -> @bone.service.parseModel response, @
        url: -> @bone.url Backbone.Model.prototype.url.call @

    createCollection: (collectionName, Model, endpoint) ->
      return @registry.collectionType.extend
        urlRoot: endpoint
        model: Model

        bone: @

        parse: (response) -> @bone.service.parseCollection response, @
        url: -> @bone.url @endpoint

    createService: ->
      unless @registry.serviceType?
        throw new ConfigurationError 'No serviceType option was provided.'

      return new @registry.serviceType @

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


  class ServiceType
    constructor: (@bone) ->

    url: (url) => url
    request: (url, options) => jQuery.ajax url, options

    discoverResources: (apiRoot) =>
      throw new AbstractionError 'discoverResources has not been implemented'

    parseModel: (response, model) =>
      throw new AbstractionError 'parseModel has not been implemented'

    parseCollection: (response, collection) =>
      throw new AbstractionError 'parseCollection has not been implemented'


  HyperBone.util = {
    naturalModelName
    naturalCollectionName
  }

  HyperBone.ConfigurationError = ConfigurationError
  HyperBone.AbstractionError = AbstractionError

  HyperBone.Bone = Bone
  HyperBone.ServiceType = ServiceType
