
# Maps resource names from the API to better names for API name discovery.
# TODO: Deprecate this.
resource_names_map =
	cartitems: 'cart_item'
	countries: 'country'
	categories: 'category'
	authenticate: 'authenticate'
	currencies: 'currency'

hyperbone.util =
	naturalModelName: (pluralName) ->
		modelName = resource_names_map[pluralName] or pluralName.substring 0, pluralName.length - 1

		parts = modelName.split('_')
		natural = ''

		for part in parts
			upperPart = (part.charAt 0).toUpperCase() + (part.substring 1).toLowerCase()
			natural = natural + upperPart

		natural
