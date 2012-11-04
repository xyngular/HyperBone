hyperbone.Collection = class HyperCollection extends Backbone.Collection
  url: ->
    @bone.url @endpoint

  @factory = (bone, model, endpoint) ->

    class AutoCollection extends HyperCollection
      bone: bone
      model: model
      endpoint: endpoint

