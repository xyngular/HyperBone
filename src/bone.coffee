hyperbone = window.hyperbone = window.hyperbone or {}

hyperbone.Bone = class Bone
	resources: {}
	models: {}

	registry: {}

	constructor: (@originalOptions) ->
		@parseOptions()
		@readSchema()

	readSchema: ->
		# Discovers our API endpoints.

		@request @registry.root

	parseOptions: ->
		@registry.root = @originalOptions.rootUrl or @originalOptions.root

		if !@originalOptions.communicationType?
			@registry.communicationType = 'cors'
		else
			@registry.communicationType = @originalOptions.communicationType.toLowerCase()

	request: (url, options) ->
		# Wraps jQuery's ajax call in order to automatically convert requests between
		# different communication types (IE, CORS or JSON-P) and generate URLs
		# when necessary.

		options = options or {}

		options.dataType = @registry.communicationType

		if @registry.communicationType == 'jsonp'
			options.crossDomain = options.crossDomain or true

			options.data = options.data or {}

		jQuery.ajax url, options
