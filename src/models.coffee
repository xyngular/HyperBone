hyperbone.Model = class HyperModel extends Backbone.Model

	@factory: (endpoint, bone) ->

		# A factory which returns a new class for whichever endpoint is passed to it
		class AutoModel extends HyperModel
			initialize: ->
				@urlRoot = endpoint
