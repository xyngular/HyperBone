{
  Bone
  Model
  ServiceType
} = require '../src'


sinon = require 'sinon'
{expect} = require 'chai'


fakeURL = 'https://google.com/?q=hyperbone'


class MockService extends ServiceType
  url: -> fakeURL
  request: (url) -> url
  discoverResources: ->

  parseModel: ->
    key: 'value'


describe 'Model', ->
  boneOptions =
    serviceType: MockService
    root: '/api/v2/'

  bone = new Bone boneOptions
  instanceRoot = boneOptions.root + 'banana/12/'

  Result = bone.createModel 'banana', instanceRoot
  instance = new Result

  describe 'created Models', ->
    describe '#url', ->
      it 'returns the instance URL using #bone', ->
        expect instance.url()
          .to.equal fakeURL

    describe '#parse', ->
      it 'return the model as parsed by #bone#service#parseModel', ->
        expect instance.parse()
          .to.deep.equal
            key: 'value'
