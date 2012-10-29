hyperbone.Model = class HyperModel extends Backbone.Model
	url: ->
		if @has '_links'
			links = @get '_links'
			url = links.self.href

		else
			url = Backbone.Model.prototype.url.call @

		url + '/'

	@factory: (endpoint, bone) ->

		# A factory which returns a new class for whichever endpoint is passed to it
		class AutoModel extends HyperModel
			initialize: ->
				@bone = bone
				@urlRoot = endpoint
