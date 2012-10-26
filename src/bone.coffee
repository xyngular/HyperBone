hyperbone.Bone = class Bone
	resources: {}

	namespaces: {}

	registry: {}

	constructor: (@originalOptions) ->
		_.extend @, Backbone.Events

		@parseOptions()

		if @originalOptions.autoDiscover? and @originalOptions.autoDiscover is true
			@originalOptions.discover()

	discover: ->
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

		for namespaceName of response._embedded
			namespace = response._embedded[namespaceName]

			namespaces[namespaceName] = @discoverResources namespace

		@namespaces = namespaces
		@trigger 'discovered'

	discoverResources: (namespace) =>
		models = {}

		for resourceName of namespace._links
			resource = namespace._links[resourceName]

			if resourceName is 'self'
				continue

			modelName = hyperbone.util.naturalModelName resourceName


			models[modelName] = hyperbone.Model.factory resource.href, @

		models

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
