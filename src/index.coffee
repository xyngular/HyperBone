amdExports = [
  'exports'
  'jquery',
  'underscore'
  'backbone'
  'backbone-relational'
]


setup = (root, factory) ->
  if typeof define is 'function' and define.amd
    define amdExports, (exports, jQuery, _, Backbone, relational) ->
      root.HyperBone = exports
      factory exports, jQuery, _, Backbone, relational.RelationalModel

  else if typeof exports is 'object'
    jQuery = require 'jQuery'

    _ = require 'underscore'
    Backbone = require 'backbone'
    {RelationalModel} = require 'backbone-relational'

    factory exports, jQuery, _, Backbone, RelationalModel

  else
    root.HyperBone = {}
    factory root.HyperBone, jQuery, root._, root.Backbone, root.Backbone.RelationalModel, root._


setup @, (HyperBone, jQuery, _, Backbone, RelationalModel) ->
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


  class Model extends RelationalModel
    parse: (response) -> @bone.service.parseModel response, @
    url: -> @bone.url Backbone.Model.prototype.url.call @

    @factory: (bone, modelName, endpoint) ->
      class AutoModel extends Model
        urlRoot: endpoint
        bone: bone

        relations: []


  class Collection extends Backbone.Collection
    parse: (response) -> @bone.service.parseCollection response, @

    url: -> @bone.url @endpoint

    @factory = (bone, collectionName, Model, endpoint) ->
      class AutoCollection extends Collection
        urlRoot: endpoint
        model: Model

        bone: bone


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

  HyperBone.Model = Model
  HyperBone.Collection = Collection

  HyperBone.Bone = Bone
  HyperBone.ServiceType = ServiceType
