hyperbone = window.hyperbone = window.hyperbone or {}

hyperbone.Bone = class Bone
	resources: {}
	models: {}

	registry: {}

	constructor: (@originalOptions) ->
		@parseOptions()

	parseOptions: ->
		@registry.root = @originalOptions.rootUrl or @originalOptions.root

		if !@originalOptions.communicationType?
			@registry.communicationType = 'cors'
		else
			@registry.communicationType = @originalOptions.communicationType.toLowerCase()
