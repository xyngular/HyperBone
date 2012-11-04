hyperbone.serviceTypes.ServiceType = class ServiceType
  constructor: (@bone) ->

  discoverResources: (apiRoot) =>

  request: (url, options) =>
    jQuery.ajax url, options

  url: (url) ->
    url

