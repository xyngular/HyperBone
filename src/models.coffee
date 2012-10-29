hyperbone.Model = class HyperModel extends Backbone.Model
	url: ->
		if @has '_links'
			links = @get '_links'
			url = links.self.href

		else
			url = Backbone.Model.prototype.url.call @

		split_url = url.split '?'

		# Ensure that trailing slashes are applied for this API
		# TODO: Toggle this via a setting
		url = split_url.shift()

		if url.substring (url.length - 1) != '/'
			split_url[0] += '/'

		# Ensure that json-p is being used properly if necessary
		if @bone.registry.communicationType == 'jsonp'
			split_url.push 'callback=?'
			split_url.push 'format=json-p'

		# Join any excess options back into the URL
		if split_url.length
			url += '?'
			url += split_url.join '&'

		url

	@factory: (endpoint, bone) ->

		# A factory which returns a new class for whichever endpoint is passed to it
		class AutoModel extends HyperModel
			initialize: ->
				@bone = bone
				@urlRoot = endpoint
