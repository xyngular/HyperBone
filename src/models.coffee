hyperbone.Model = class HyperModel extends Backbone.Model
	url: ->
		if @has '_links'
			links = @get '_links'
			links.self.href

		else
			Backbone.Model.prototype.url.call @

	@factory: (endpoint, bone) ->

		# A factory which returns a new class for whichever endpoint is passed to it
		class AutoModel extends HyperModel
			initialize: ->
				@urlRoot = endpoint
