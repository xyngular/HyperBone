hyperbone.serviceTypes.ServiceType = class ServiceType
  constructor: (@bone) ->

  discoverResources: (apiRoot) =>

  url: (url) =>
    url

  request: (url, options) =>
    jQuery.ajax url, options

  parseModel: (response, model) =>

  parseCollection: (response, collection) =>

