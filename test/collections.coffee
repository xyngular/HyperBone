{
  Bone
  Model
  Collection
  ServiceType
} = require '../src'


sinon = require 'sinon'
{expect} = require 'chai'


fakeURL = 'https://google.com/?q=hyperbone'


class MockService extends ServiceType
  url: -> fakeURL
  request: (url) -> url
  discoverResources: ->

  parseCollection: ->
    key: 'value'


describe 'Collection', ->
  boneOptions =
    serviceType: MockService
    root: '/api/v2/'

  bone = new Bone boneOptions
  instanceRoot = boneOptions.root + 'bananas/'

  ModelType = bone.createModel 'banana', instanceRoot + '12/'
  Result = bone.createCollection 'bananas', ModelType, instanceRoot

  describe 'generated Collections', ->
    it 'generates a new Collection type', ->
      expect Result::urlRoot
        .to.equal instanceRoot

      expect Result::bone
        .to.equal bone

  describe '#url', ->
    it 'returns the instance URL using #bone', ->
      instance = new Result

      expect instance.url()
        .to.equal fakeURL
