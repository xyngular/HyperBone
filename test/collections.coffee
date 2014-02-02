{Bone} = require '../src/bone'
{Model} = require '../src/models'
{Collection} = require '../src/collection'
{ServiceType} = require '../src/service_types/base'


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

  ModelType = Model.factory bone, 'banana', boneOptions.root + 'bananas/'

  bone = new Bone boneOptions
  instanceRoot = boneOptions.root + 'bananas/'

  Result = Collection.factory bone, 'bananas', ModelType, instanceRoot

  describe '#factory', ->
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
