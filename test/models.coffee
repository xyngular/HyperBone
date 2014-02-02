{Bone} = require '../src/bone'
{Model} = require '../src/models'
{ServiceType} = require '../src/service_types/base'


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
  instanceRoot = boneOptions.root + 'banana/'

  Result = Model.factory bone, 'banana', instanceRoot
  instance = new Result

  describe '#factory', ->
    it 'generates a new RelationalModel type', ->
      expect Result::urlRoot
        .to.equal instanceRoot

      expect Result::relations
        .to.deep.equal []

      expect Result::bone
        .to.equal bone

  describe '#url', ->
    it 'returns the instance URL using #bone', ->
      expect instance.url()
        .to.equal fakeURL

  describe '#parse', ->
    it 'return the model as parsed by #bone#service#parseModel', ->
      expect instance.parse()
        .to.deep.equal
          key: 'value'
