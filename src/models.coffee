# The MIT License (MIT)
# 
# Copyright (c) 2013 Alytis
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

hyperbone.Model = class HyperModel extends Backbone.RelationalModel
  parse: (response) ->
    @bone.service.parseModel response, @

  url: ->
    if @meta? and @meta._links? and @meta._links.self?
      url = @meta.links.self.href

    else
      url = Backbone.Model.prototype.url.call @

    @bone.url url

  @factory: (bone, modelName, endpoint) ->
    ### A factory which creates a new model for the given endpoint.

    ###

    class AutoModel extends HyperModel
      relations: []
      bone: bone
      urlRoot: endpoint

    return AutoModel

