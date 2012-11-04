hyperbone.Collection = class HyperCollection extends Backbone.Collection
  parse: (response) ->
    @bone.service.parseCollection response, @

  url: ->
    @bone.url @endpoint

  @factory = (bone, model, endpoint) ->

    class AutoCollection extends HyperCollection
      bone: bone
      model: model
      endpoint: endpoint

