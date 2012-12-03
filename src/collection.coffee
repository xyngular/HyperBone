hyperbone.Collection = class HyperCollection extends Backbone.Collection
  parse: (response) ->
    @bone.service.parseCollection response, @

  url: ->
    @bone.url @endpoint

  @factory = (bone, collectionName, model, endpoint) ->
    ### A factory that creates a new collection for the given endpoint.

    ###

    class AutoCollection extends HyperCollection
      bone: bone
      model: model
      endpoint: endpoint

