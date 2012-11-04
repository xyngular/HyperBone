hyperbone.util =
  naturalModelName: (modelName) ->
    parts = modelName.split('_')
    natural = ''

    for part in parts
      upperPart = (part.charAt 0).toUpperCase() + (part.substring 1).toLowerCase()
      natural = natural + upperPart

    natural

  naturalCollectionName: (resourceName) ->
    modelName = hyperbone.util.naturalModelName resourceName
    modelName + 'Collection'

