hyperbone.Model = class HyperModel extends Backbone.RelationalModel
  parse: (response) ->
    @bone.service.parseModel response, @

  url: ->
    if @meta? and @meta._links? and @meta._links.self?
      url = @meta.links.self.href

    else
      url = Backbone.Model.prototype.url.call @

    @bone.url url

  @factory: (bone, modelName, endpoint) ->
    ### A factory which creates a new model for the given endpoint.

    ###

    class AutoModel extends HyperModel
      bone: bone
      urlRoot: endpoint

