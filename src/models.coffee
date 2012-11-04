hyperbone.Model = class HyperModel extends Backbone.Model
  parse: (response) ->
    @bone.service.parseModel response, @

  url: ->
    if @has '_links'
      links = @get '_links'
      url = links.self.href

    else
      url = Backbone.Model.prototype.url.call @

    @bone.url url

  @factory: (bone, endpoint) ->

    # A factory which returns a new class for whichever endpoint is passed to it
    class AutoModel extends HyperModel
      bone: bone
      urlRoot: endpoint
