hyperbone = window.hyperbone = window.hyperbone or {}

hyperbone.naturalModelName = (modelName) ->
	parts = modelName.split('_')
	natural = ''

	for part in parts
		upperPart = (part.charAt 0).toUpperCase() + (part.substring 1).toLowerCase()
		natural = natural + upperPart

	natural

hyperbone.Bone = class Bone
	resources: {}

	namespaces: {}

	registry: {}

	constructor: (@originalOptions) ->
		@parseOptions()
		@readSchema()

	parseOptions: =>
		@registry.root = @originalOptions.rootUrl or @originalOptions.root

		if !@originalOptions.communicationType?
			@registry.communicationType = 'cors'
		else
			@registry.communicationType = @originalOptions.communicationType.toLowerCase()

	readSchema: =>
		# Discovers our API endpoints.

		@request @registry.root,
			success: @updateSchema

	updateSchema: (response) =>
		namespaces = {}

		for namespace of response._embedded
			namespaces[namespace] = @discoverNamespace response._embedded[namespace]

		@namespaces = namespaces

	discoverNamespace: (namespace) =>
		for namespaceName of namespace._links
			if namespaceName is 'self'
				continue

			namespaceName = hyperbone.naturalModelName namespaceName

		namespace

	request: (url, options) =>
		# Wraps jQuery's ajax call in order to automatically convert requests between
		# different communication types (IE, CORS or JSON-P) and generate URLs
		# when necessary.

		options = options or {}

		options.dataType = @registry.communicationType

		# TODO: Get this to use the HTTP standard Accept header, not ?format=json-p
		if @registry.communicationType == 'jsonp'
			options.crossDomain = options.crossDomain or true

			options.data = options.data or {}
			options.data.format = 'json-p'

		jQuery.ajax url, options
