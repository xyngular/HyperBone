hyperbone.Bone = class Bone
  models: {}

  service: null

  registry:
    communicationType: 'cors'
    serviceType: hyperbone.serviceTypes.HALServiceType

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
